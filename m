Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6C5AE5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiIFKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiIFKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:49:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691F7C33D;
        Tue,  6 Sep 2022 03:48:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 28FD11F9BF;
        Tue,  6 Sep 2022 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662461292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jl/AwoQC7omJtY8qaihwuhwpfv9ehxsS4h2wzd8CKzc=;
        b=xkDX8Ij15AD2TDmoqGVD+4LRk+9V1ZIvQJ6jbhx0S+EQ8/pvprAlGTaRbniPvGL9igRtJe
        z3Id3zxFqq1yC4HgjA7j/cYrqmOEZEmfM/Cp/SMGonbD3pbPY0OL/tPCQZSG8U0SMl8SJA
        3+Z6zUZ96unUGtL2fSfHvhX0yixsf5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662461292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jl/AwoQC7omJtY8qaihwuhwpfv9ehxsS4h2wzd8CKzc=;
        b=6UnIPwdWXRWGvKl26dpxf6fBlwfo8DprLQufs9eGP6ScR50ibzZdnIZ0yXHrqwz5XPHa8/
        EEJ7+/VsBH4ZORDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBD7F2C143;
        Tue,  6 Sep 2022 10:48:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 2/4] tty: serial: introduce transmit helper generators
Date:   Tue,  6 Sep 2022 12:48:03 +0200
Message-Id: <20220906104805.23211-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906104805.23211-1-jslaby@suse.cz>
References: <20220906104805.23211-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

So unify the above into two helper generators:
* DEFINE_UART_PORT_TX_HELPER_LIMITED() -- it performs the above taking
  the written characters limit into account, and
* DEFINE_UART_PORT_TX_HELPER() -- the same as above, except it only
  checks the HW readiness, not the characters limit.

The HW specific operations (as stated as "differences" above) are passed
as arguments to the macros. They are:
* tx_ready -- returns true if HW can accept more data.
* put_char -- write a character to the device.
* tx_done -- when the write loop is done, perform arbitrary action
  before potential invocation of ops->stop_tx() happens.

Note that the above macros are generators. This means the code is
generated in place and the above 3 arguments are "inlined". I.e. no
added penalty by generating call instructions for every single
character. Nor any indirect calls. (As in previous versions of this
patchset.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v3] remove port + ch parameters of the macros (Greg)
    
    [v2] instead of a function (uart_port_tx_limit()) in serial_core,
         generate these in-place using macros. Thus eliminating "call"
         penalty.

 Documentation/driver-api/serial/driver.rst |  3 +
 include/linux/serial_core.h                | 81 ++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 23c6b956cd90..25775bf1fcc6 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -78,6 +78,9 @@ Other functions
            uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
            uart_try_toggle_sysrq uart_get_console
 
+.. kernel-doc:: include/linux/serial_core.h
+   :identifiers: DEFINE_UART_PORT_TX_HELPER_LIMITED DEFINE_UART_PORT_TX_HELPER
+
 Other notes
 -----------
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6e4f4765d209..69abcc05fcfb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -646,6 +646,87 @@ struct uart_driver {
 
 void uart_write_wakeup(struct uart_port *port);
 
+#define __DEFINE_UART_PORT_TX_HELPER(name, tx_ready, put_char, tx_done,	  \
+		for_test, for_post, ...)				  \
+unsigned int name(struct uart_port *port __VA_OPT__(,) __VA_ARGS__)	  \
+{									  \
+	struct circ_buf *xmit = &port->state->xmit;			  \
+	unsigned int pending;						  \
+	u8 ch;								  \
+									  \
+	for (; (for_test) && (tx_ready); (for_post), port->icount.tx++) { \
+		if (port->x_char) {					  \
+			ch = port->x_char;				  \
+			(put_char);					  \
+			port->x_char = 0;				  \
+			continue;					  \
+		}							  \
+									  \
+		if (uart_circ_empty(xmit) || uart_tx_stopped(port))	  \
+			break;						  \
+									  \
+		ch = xmit->buf[xmit->tail];				  \
+		(put_char);						  \
+		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;		  \
+	}								  \
+									  \
+	(tx_done);							  \
+									  \
+	pending = uart_circ_chars_pending(xmit);			  \
+	if (pending < WAKEUP_CHARS) {					  \
+		uart_write_wakeup(port);				  \
+									  \
+		if (pending == 0)					  \
+			port->ops->stop_tx(port);			  \
+	}								  \
+									  \
+	return pending;							  \
+}
+
+/**
+ * DEFINE_UART_PORT_TX_HELPER_LIMITED -- generate transmit helper for uart_port
+ *	with count limiting
+ * @name: name of the helper to generate
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * This macro generates a function @name. The generated function is meant as a
+ * helper to transmit characters from the xmit buffer to the hardware using
+ * @put_char(). It does so until count (passed to @name) characters are sent
+ * and while @tx_ready evaluates to true.
+ *
+ * The generated function returns the number of characters in the xmit buffer
+ * when done.
+ *
+ * The expression in macro parameters are free to use @port (uart port) and @ch
+ * (character to send) variables and shall be designed as follows:
+ *  * **tx_ready:** should evaluate to true if the HW can accept more data to
+ *    be sent. This parameter can be %true, which means the HW is always ready.
+ *  * **put_char:** shall write @ch to the device of @port.
+ *  * **tx_done:** when the write loop is done, this can perform arbitrary
+ *    action before potential invocation of ops->stop_tx() happens. If the
+ *    driver does not need to do anything, use e.g. ({}).
+ *
+ * For all of them, @port->lock is held, interrupts are locally disabled and
+ * the expressions must not sleep.
+ */
+#define DEFINE_UART_PORT_TX_HELPER_LIMITED(name, tx_ready, put_char, tx_done) \
+	__DEFINE_UART_PORT_TX_HELPER(name, tx_ready, put_char, tx_done,	      \
+			count, count--, unsigned int count)
+
+/**
+ * DEFINE_UART_PORT_TX_HELPER -- generate transmit helper for uart_port
+ * @name: name of the helper to generate
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ *
+ * See DEFINE_UART_PORT_TX_HELPER_LIMITED() for more details.
+ */
+#define DEFINE_UART_PORT_TX_HELPER(name, tx_ready, put_char)		\
+	__DEFINE_UART_PORT_TX_HELPER(name, tx_ready, put_char, ({}),	\
+			true, ({}))
+
 /*
  * Baud rate helpers.
  */
-- 
2.37.3

