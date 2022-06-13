Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB015548E15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382715AbiFMOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381431AbiFMOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:04:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D892BB2D;
        Mon, 13 Jun 2022 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655120361; x=1686656361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G7QQ+WW3LOvtPCdg1OVAOqL6XRPidEyJLiCpfLWTSgM=;
  b=kyomMcxqDR2f7EPFb4BtDU7kLOMwDtShk0FJQPRM0nJv+caCXuAy82lc
   ql6MXXyf+stufw6+y7iKaKMBN9v5+nRn5MgJpkiM16vaORqGKaodqrqpu
   Tsl80wHfFls7BLZtSGtQTstNiXVGg1fxS/pdm20GGqLYJ9KXLdi12/vB1
   l9VQRXS0uOKfp7ESQ8Qqr9kGRe6ZeT2/Kj9EJJV3jjtjZDWuuyExvNDyP
   lMv/2Fv5MwU6hpjbSywZtjrH1IsC5ubTMZjItPfcI8sT1r6DXFNBhWIj9
   DYYAciYbF0nWcZNT5iFBPx+EvQ9RAweOQlwevgqCvGEMft8fmWTYU+pHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="342227628"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="342227628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 04:39:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="639685879"
Received: from fnechitx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.40.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 04:39:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: Drop timeout from uart_port
Date:   Mon, 13 Jun 2022 14:39:05 +0300
Message-Id: <20220613113905.22962-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 31f6bd7fad3b ("serial: Store character timing information
to uart_port"), per frame timing information is available on uart_port.
Uart port's timeout can be derived from frame_time by multiplying with
fifosize.

Most callers of uart_poll_timeout are not made under port's lock. To be
on the safe side, make sure frame_time is only accessed once. As
fifo_size is effectively a constant, it shouldn't cause any issues.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 Documentation/driver-api/serial/driver.rst |  5 +++--
 drivers/tty/serial/mux.c                   |  6 ------
 drivers/tty/serial/serial_core.c           | 25 ++++++++++---------------
 include/linux/serial_core.h                | 16 ++++++++++++++--
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 7ef83fd3917b..1e7ab4142d49 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -422,8 +422,9 @@ Other functions
 ---------------
 
 uart_update_timeout(port,cflag,baud)
-	Update the FIFO drain timeout, port->timeout, according to the
-	number of bits, parity, stop bits and baud rate.
+	Update the frame timing information according to the number of bits,
+	parity, stop bits and baud rate. The FIFO drain timeout is derived
+	from the frame timing information.
 
 	Locking: caller is expected to take port->lock
 
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 643dfbcc43f9..0ba0f4d9459d 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -481,12 +481,6 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->line	= port_cnt;
 		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MUX_CONSOLE);
 
-		/* The port->timeout needs to match what is present in
-		 * uart_wait_until_sent in serial_core.c.  Otherwise
-		 * the time spent in msleep_interruptable will be very
-		 * long, causing the appearance of a console hang.
-		 */
-		port->timeout   = HZ / 50;
 		spin_lock_init(&port->lock);
 
 		status = uart_add_one_port(&mux_driver, port);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 621fc15e2e54..e068b16d770d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -327,13 +327,14 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 }
 
 /**
- *	uart_update_timeout - update per-port FIFO timeout.
+ *	uart_update_timeout - update per-port frame timing information.
  *	@port:  uart_port structure describing the port
  *	@cflag: termios cflag value
  *	@baud:  speed of the port
  *
- *	Set the port FIFO timeout value.  The @cflag value should
- *	reflect the actual hardware settings.
+ *	Set the port frame timing information from which the FIFO timeout
+ *	value is derived. The @cflag value should reflect the actual hardware
+ *	settings.
  */
 void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
@@ -343,13 +344,6 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 	u64 frame_time;
 
 	frame_time = (u64)size * NSEC_PER_SEC;
-	size *= port->fifosize;
-
-	/*
-	 * Figure the timeout to send the above number of bits.
-	 * Add .02 seconds of slop
-	 */
-	port->timeout = (HZ * size) / baud + HZ/50;
 	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
@@ -1698,7 +1692,7 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
-	unsigned long char_time, expire;
+	unsigned long char_time, expire, fifo_timeout;
 
 	port = uart_port_ref(state);
 	if (!port)
@@ -1728,12 +1722,13 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 		 * amount of time to send the entire FIFO, it probably won't
 		 * ever clear.  This assumes the UART isn't doing flow
 		 * control, which is currently the case.  Hence, if it ever
-		 * takes longer than port->timeout, this is probably due to a
+		 * takes longer than FIFO timeout, this is probably due to a
 		 * UART bug of some kind.  So, we clamp the timeout parameter at
-		 * 2*port->timeout.
+		 * 2 * FIFO timeout.
 		 */
-		if (timeout == 0 || timeout > 2 * port->timeout)
-			timeout = 2 * port->timeout;
+		fifo_timeout = uart_fifo_timeout(port);
+		if (timeout == 0 || timeout > 2 * fifo_timeout)
+			timeout = 2 * fifo_timeout;
 	}
 
 	expire = jiffies + timeout;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5518b70177b3..373783487b2e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -231,7 +231,6 @@ struct uart_port {
 
 	int			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
-	unsigned int		timeout;		/* character-based timeout */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
 	const struct uart_ops	*ops;
@@ -334,10 +333,23 @@ unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termios
 				unsigned int max);
 unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 
+/*
+ * Calculates FIFO drain time.
+ */
+static inline unsigned long uart_fifo_timeout(struct uart_port *port)
+{
+	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+
+	/* Add .02 seconds of slop */
+	fifo_timeout += 20 * NSEC_PER_MSEC;
+
+	return max(nsecs_to_jiffies(fifo_timeout), 1UL);
+}
+
 /* Base timer interval for polling */
 static inline int uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = port->timeout;
+	int timeout = uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }

-- 
tg: (65534736d9a5..) serial/drop-timeout (depends on: tty-next)
