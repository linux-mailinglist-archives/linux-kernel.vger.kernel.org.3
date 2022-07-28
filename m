Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3327758387C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiG1GLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1GLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:11:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10230F67;
        Wed, 27 Jul 2022 23:10:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF5EF5C133;
        Thu, 28 Jul 2022 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kgCSAZPIwd9TCZVZwUdLXjznw3PYzZbgS5D3oD/Gl2o=;
        b=xCaXziUA6HFVVkYbfm0O/vvZYd5wra1iMg+C4tZdXSEMAILuoiMB5bw0H8iql2L2Tv1kk3
        0Du3CfNdVIQJ9lCvuRdOkueSd4MMVXw9yIiAsyQdie6LtwVqNuFR/A91yon4iZrTbV30It
        uH09Vkb1EZc6luOXxrsT3/19AthvHVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kgCSAZPIwd9TCZVZwUdLXjznw3PYzZbgS5D3oD/Gl2o=;
        b=750A8zrsWCwe/LLiSYHZZtp+RsBSH+TPIvhH8rgWFq//JPH9Mnhz3Zmf+FtfdKDCaR/l4w
        pXNlBWB6gTTfBLBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9955C2C141;
        Thu, 28 Jul 2022 06:10:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/6] Documentation: serial: move uart_ops documentation to the struct
Date:   Thu, 28 Jul 2022 08:10:51 +0200
Message-Id: <20220728061056.20799-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it's a lot of text, it always helps to keep it up to date when
it's by the source. (And not in a separate file.)

The documentation tooling also makes sure that all members of the
structure are documented. (If not, it complains loudly.)

Finally, there needs to be no comments inlined in the structure, so they
are dropped as they are superfluous now.

The compilation time of this header (tested with serial_core.c) didn't
change in my testing at all.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst | 358 +--------------------
 include/linux/serial_core.h                | 345 +++++++++++++++++++-
 2 files changed, 331 insertions(+), 372 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index ee1679858aa2..cb0ec6db4f1e 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -63,362 +63,8 @@ commonly referred to as the port mutex.
 uart_ops
 --------
 
-The uart_ops structure is the main interface between serial_core and the
-hardware specific driver.  It contains all the methods to control the
-hardware.
-
-  tx_empty(port)
-	This function tests whether the transmitter fifo and shifter
-	for the port described by 'port' is empty.  If it is empty,
-	this function should return TIOCSER_TEMT, otherwise return 0.
-	If the port does not support this operation, then it should
-	return TIOCSER_TEMT.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-	This call must not sleep
-
-  set_mctrl(port, mctrl)
-	This function sets the modem control lines for port described
-	by 'port' to the state described by mctrl.  The relevant bits
-	of mctrl are:
-
-		- TIOCM_RTS	RTS signal.
-		- TIOCM_DTR	DTR signal.
-		- TIOCM_OUT1	OUT1 signal.
-		- TIOCM_OUT2	OUT2 signal.
-		- TIOCM_LOOP	Set the port into loopback mode.
-
-	If the appropriate bit is set, the signal should be driven
-	active.  If the bit is clear, the signal should be driven
-	inactive.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  get_mctrl(port)
-	Returns the current state of modem control inputs.  The state
-	of the outputs should not be returned, since the core keeps
-	track of their state.  The state information should include:
-
-		- TIOCM_CAR	state of DCD signal
-		- TIOCM_CTS	state of CTS signal
-		- TIOCM_DSR	state of DSR signal
-		- TIOCM_RI	state of RI signal
-
-	The bit is set if the signal is currently driven active.  If
-	the port does not support CTS, DCD or DSR, the driver should
-	indicate that the signal is permanently active.  If RI is
-	not available, the signal should not be indicated as active.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  stop_tx(port)
-	Stop transmitting characters.  This might be due to the CTS
-	line becoming inactive or the tty layer indicating we want
-	to stop transmission due to an XOFF character.
-
-	The driver should stop transmitting characters as soon as
-	possible.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  start_tx(port)
-	Start transmitting characters.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  throttle(port)
-	Notify the serial driver that input buffers for the line discipline are
-	close to full, and it should somehow signal that no more characters
-	should be sent to the serial port.
-	This will be called only if hardware assisted flow control is enabled.
-
-	Locking: serialized with .unthrottle() and termios modification by the
-	tty layer.
-
-  unthrottle(port)
-	Notify the serial driver that characters can now be sent to the serial
-	port without fear of overrunning the input buffers of the line
-	disciplines.
-
-	This will be called only if hardware assisted flow control is enabled.
-
-	Locking: serialized with .throttle() and termios modification by the
-	tty layer.
-
-  send_xchar(port,ch)
-	Transmit a high priority character, even if the port is stopped.
-	This is used to implement XON/XOFF flow control and tcflow().  If
-	the serial driver does not implement this function, the tty core
-	will append the character to the circular buffer and then call
-	start_tx() / stop_tx() to flush the data out.
-
-	Do not transmit if ch == '\0' (__DISABLED_CHAR).
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  stop_rx(port)
-	Stop receiving characters; the port is in the process of
-	being closed.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  enable_ms(port)
-	Enable the modem status interrupts.
-
-	This method may be called multiple times.  Modem status
-	interrupts should be disabled when the shutdown method is
-	called.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  break_ctl(port,ctl)
-	Control the transmission of a break signal.  If ctl is
-	nonzero, the break signal should be transmitted.  The signal
-	should be terminated when another call is made with a zero
-	ctl.
-
-	Locking: caller holds tty_port->mutex
-
-  startup(port)
-	Grab any interrupt resources and initialise any low level driver
-	state.  Enable the port for reception.  It should not activate
-	RTS nor DTR; this will be done via a separate call to set_mctrl.
-
-	This method will only be called when the port is initially opened.
-
-	Locking: port_sem taken.
-
-	Interrupts: globally disabled.
-
-  shutdown(port)
-	Disable the port, disable any break condition that may be in
-	effect, and free any interrupt resources.  It should not disable
-	RTS nor DTR; this will have already been done via a separate
-	call to set_mctrl.
-
-	Drivers must not access port->state once this call has completed.
-
-	This method will only be called when there are no more users of
-	this port.
-
-	Locking: port_sem taken.
-
-	Interrupts: caller dependent.
-
-  flush_buffer(port)
-	Flush any write buffers, reset any DMA state and stop any
-	ongoing DMA transfers.
-
-	This will be called whenever the port->state->xmit circular
-	buffer is cleared.
-
-	Locking: port->lock taken.
-
-	Interrupts: locally disabled.
-
-	This call must not sleep
-
-  set_termios(port,termios,oldtermios)
-	Change the port parameters, including word length, parity, stop
-	bits.  Update read_status_mask and ignore_status_mask to indicate
-	the types of events we are interested in receiving.  Relevant
-	termios->c_cflag bits are:
-
-		CSIZE
-			- word size
-		CSTOPB
-			- 2 stop bits
-		PARENB
-			- parity enable
-		PARODD
-			- odd parity (when PARENB is in force)
-		ADDRB
-			- address bit (changed through .rs485_config()).
-		CREAD
-			- enable reception of characters (if not set,
-			  still receive characters from the port, but
-			  throw them away.
-		CRTSCTS
-			- if set, enable CTS status change reporting
-		CLOCAL
-			- if not set, enable modem status change
-			  reporting.
-
-	Relevant termios->c_iflag bits are:
-
-		INPCK
-			- enable frame and parity error events to be
-			  passed to the TTY layer.
-		BRKINT / PARMRK
-			- both of these enable break events to be
-			  passed to the TTY layer.
-
-		IGNPAR
-			- ignore parity and framing errors
-		IGNBRK
-			- ignore break errors,  If IGNPAR is also
-			  set, ignore overrun errors as well.
-
-	The interaction of the iflag bits is as follows (parity error
-	given as an example):
-
-	=============== ======= ======  =============================
-	Parity error	INPCK	IGNPAR
-	=============== ======= ======  =============================
-	n/a		0	n/a	character received, marked as
-					TTY_NORMAL
-	None		1	n/a	character received, marked as
-					TTY_NORMAL
-	Yes		1	0	character received, marked as
-					TTY_PARITY
-	Yes		1	1	character discarded
-	=============== ======= ======  =============================
-
-	Other flags may be used (eg, xon/xoff characters) if your
-	hardware supports hardware "soft" flow control.
-
-	Locking: caller holds tty_port->mutex
-
-	Interrupts: caller dependent.
-
-	This call must not sleep
-
-  set_ldisc(port,termios)
-	Notifier for discipline change. See ../tty/tty_ldisc.rst.
-
-	Locking: caller holds tty_port->mutex
-
-  pm(port,state,oldstate)
-	Perform any power management related activities on the specified
-	port.  State indicates the new state (defined by
-	enum uart_pm_state), oldstate indicates the previous state.
-
-	This function should not be used to grab any resources.
-
-	This will be called when the port is initially opened and finally
-	closed, except when the port is also the system console.  This
-	will occur even if CONFIG_PM is not set.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  type(port)
-	Return a pointer to a string constant describing the specified
-	port, or return NULL, in which case the string 'unknown' is
-	substituted.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  release_port(port)
-	Release any memory and IO region resources currently in use by
-	the port.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  request_port(port)
-	Request any memory and IO region resources required by the port.
-	If any fail, no resources should be registered when this function
-	returns, and it should return -EBUSY on failure.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  config_port(port,type)
-	Perform any autoconfiguration steps required for the port.  `type`
-	contains a bit mask of the required configuration.  UART_CONFIG_TYPE
-	indicates that the port requires detection and identification.
-	port->type should be set to the type found, or PORT_UNKNOWN if
-	no port was detected.
-
-	UART_CONFIG_IRQ indicates autoconfiguration of the interrupt signal,
-	which should be probed using standard kernel autoprobing techniques.
-	This is not necessary on platforms where ports have interrupts
-	internally hard wired (eg, system on a chip implementations).
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  verify_port(port,serinfo)
-	Verify the new serial port information contained within serinfo is
-	suitable for this port type.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  ioctl(port,cmd,arg)
-	Perform any port specific IOCTLs.  IOCTL commands must be defined
-	using the standard numbering system found in <asm/ioctl.h>
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-  poll_init(port)
-	Called by kgdb to perform the minimal hardware initialization needed
-	to support poll_put_char() and poll_get_char().  Unlike ->startup()
-	this should not request interrupts.
-
-	Locking: tty_mutex and tty_port->mutex taken.
-
-	Interrupts: n/a.
-
-  poll_put_char(port,ch)
-	Called by kgdb to write a single character directly to the serial
-	port.  It can and should block until there is space in the TX FIFO.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-	This call must not sleep
-
-  poll_get_char(port)
-	Called by kgdb to read a single character directly from the serial
-	port.  If data is available, it should be returned; otherwise
-	the function should return NO_POLL_CHAR immediately.
-
-	Locking: none.
-
-	Interrupts: caller dependent.
-
-	This call must not sleep
+.. kernel-doc:: include/linux/serial_core.h
+   :identifiers: uart_ops
 
 Other functions
 ---------------
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 0fc0bb661833..aef3145f2032 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -31,9 +31,336 @@ struct serial_struct;
 struct device;
 struct gpio_desc;
 
-/*
+/**
+ * struct uart_ops -- interface between serial_core and the driver
+ *
  * This structure describes all the operations that can be done on the
- * physical hardware.  See Documentation/driver-api/serial/driver.rst for details.
+ * physical hardware.
+ *
+ * @tx_empty: ``unsigned int ()(struct uart_port *port)``
+ *
+ *	This function tests whether the transmitter fifo and shifter for the
+ *	@port is empty. If it is empty, this function should return
+ *	%TIOCSER_TEMT, otherwise return 0. If the port does not support this
+ *	operation, then it should return %TIOCSER_TEMT.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *	This call must not sleep
+ *
+ * @set_mctrl: ``void ()(struct uart_port *port, unsigned int mctrl)``
+ *
+ *	This function sets the modem control lines for @port to the state
+ *	described by @mctrl. The relevant bits of @mctrl are:
+ *
+ *		- %TIOCM_RTS	RTS signal.
+ *		- %TIOCM_DTR	DTR signal.
+ *		- %TIOCM_OUT1	OUT1 signal.
+ *		- %TIOCM_OUT2	OUT2 signal.
+ *		- %TIOCM_LOOP	Set the port into loopback mode.
+ *
+ *	If the appropriate bit is set, the signal should be driven
+ *	active.  If the bit is clear, the signal should be driven
+ *	inactive.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @get_mctrl: ``unsigned int ()(struct uart_port *port)``
+ *
+ *	Returns the current state of modem control inputs of @port. The state
+ *	of the outputs should not be returned, since the core keeps track of
+ *	their state. The state information should include:
+ *
+ *		- %TIOCM_CAR	state of DCD signal
+ *		- %TIOCM_CTS	state of CTS signal
+ *		- %TIOCM_DSR	state of DSR signal
+ *		- %TIOCM_RI	state of RI signal
+ *
+ *	The bit is set if the signal is currently driven active.  If
+ *	the port does not support CTS, DCD or DSR, the driver should
+ *	indicate that the signal is permanently active. If RI is
+ *	not available, the signal should not be indicated as active.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @stop_tx: ``void ()(struct uart_port *port)``
+ *
+ *	Stop transmitting characters. This might be due to the CTS line
+ *	becoming inactive or the tty layer indicating we want to stop
+ *	transmission due to an %XOFF character.
+ *
+ *	The driver should stop transmitting characters as soon as possible.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @start_tx: ``void ()(struct uart_port *port)``
+ *
+ *	Start transmitting characters.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @throttle: ``void ()(struct uart_port *port)``
+ *
+ *	Notify the serial driver that input buffers for the line discipline are
+ *	close to full, and it should somehow signal that no more characters
+ *	should be sent to the serial port.
+ *	This will be called only if hardware assisted flow control is enabled.
+ *
+ *	Locking: serialized with @unthrottle() and termios modification by the
+ *	tty layer.
+ *
+ * @unthrottle: ``void ()(struct uart_port *port)``
+ *
+ *	Notify the serial driver that characters can now be sent to the serial
+ *	port without fear of overrunning the input buffers of the line
+ *	disciplines.
+ *
+ *	This will be called only if hardware assisted flow control is enabled.
+ *
+ *	Locking: serialized with @throttle() and termios modification by the
+ *	tty layer.
+ *
+ * @send_xchar: ``void ()(struct uart_port *port, char ch)``
+ *
+ *	Transmit a high priority character, even if the port is stopped. This
+ *	is used to implement XON/XOFF flow control and tcflow(). If the serial
+ *	driver does not implement this function, the tty core will append the
+ *	character to the circular buffer and then call start_tx() / stop_tx()
+ *	to flush the data out.
+ *
+ *	Do not transmit if @ch == '\0' (%__DISABLED_CHAR).
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @stop_rx: ``void ()(struct uart_port *port)``
+ *
+ *	Stop receiving characters; the @port is in the process of being closed.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @enable_ms: ``void ()(struct uart_port *port)``
+ *
+ *	Enable the modem status interrupts.
+ *
+ *	This method may be called multiple times. Modem status interrupts
+ *	should be disabled when the @shutdown() method is called.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @break_ctl: ``void ()(struct uart_port *port, int ctl)``
+ *
+ *	Control the transmission of a break signal. If @ctl is nonzero, the
+ *	break signal should be transmitted. The signal should be terminated
+ *	when another call is made with a zero @ctl.
+ *
+ *	Locking: caller holds tty_port->mutex
+ *
+ * @startup: ``int ()(struct uart_port *port)``
+ *
+ *	Grab any interrupt resources and initialise any low level driver state.
+ *	Enable the port for reception. It should not activate RTS nor DTR;
+ *	this will be done via a separate call to @set_mctrl().
+ *
+ *	This method will only be called when the port is initially opened.
+ *
+ *	Locking: port_sem taken.
+ *	Interrupts: globally disabled.
+ *
+ * @shutdown: ``void ()(struct uart_port *port)``
+ *
+ *	Disable the @port, disable any break condition that may be in effect,
+ *	and free any interrupt resources. It should not disable RTS nor DTR;
+ *	this will have already been done via a separate call to @set_mctrl().
+ *
+ *	Drivers must not access @port->state once this call has completed.
+ *
+ *	This method will only be called when there are no more users of this
+ *	@port.
+ *
+ *	Locking: port_sem taken.
+ *	Interrupts: caller dependent.
+ *
+ * @flush_buffer: ``void ()(struct uart_port *port)``
+ *
+ *	Flush any write buffers, reset any DMA state and stop any ongoing DMA
+ *	transfers.
+ *
+ *	This will be called whenever the @port->state->xmit circular buffer is
+ *	cleared.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
+ * @set_termios: ``void ()(struct uart_port *port, struct ktermios *new,
+ *			struct ktermios *old)``
+ *
+ *	Change the @port parameters, including word length, parity, stop bits.
+ *	Update @port->read_status_mask and @port->ignore_status_mask to
+ *	indicate the types of events we are interested in receiving. Relevant
+ *	ktermios::c_cflag bits are:
+ *
+ *	- %CSIZE - word size
+ *	- %CSTOPB - 2 stop bits
+ *	- %PARENB - parity enable
+ *	- %PARODD - odd parity (when %PARENB is in force)
+ *	- %ADDRB - address bit (changed through uart_port::rs485_config()).
+ *	- %CREAD - enable reception of characters (if not set, still receive
+ *	  characters from the port, but throw them away).
+ *	- %CRTSCTS - if set, enable CTS status change reporting.
+ *	- %CLOCAL - if not set, enable modem status change reporting.
+ *
+ *	Relevant ktermios::c_iflag bits are:
+ *
+ *	- %INPCK - enable frame and parity error events to be passed to the TTY
+ *	  layer.
+ *	- %BRKINT / %PARMRK - both of these enable break events to be passed to
+ *	  the TTY layer.
+ *	- %IGNPAR - ignore parity and framing errors.
+ *	- %IGNBRK - ignore break errors. If %IGNPAR is also set, ignore overrun
+ *	  errors as well.
+ *
+ *	The interaction of the ktermios::c_iflag bits is as follows (parity
+ *	error given as an example):
+ *
+ *	============ ======= ======= =========================================
+ *	Parity error INPCK   IGNPAR
+ *	============ ======= ======= =========================================
+ *	n/a	     0	     n/a     character received, marked as %TTY_NORMAL
+ *	None	     1	     n/a     character received, marked as %TTY_NORMAL
+ *	Yes	     1	     0	     character received, marked as %TTY_PARITY
+ *	Yes	     1	     1	     character discarded
+ *	============ ======= ======= =========================================
+ *
+ *	Other flags may be used (eg, xon/xoff characters) if your hardware
+ *	supports hardware "soft" flow control.
+ *
+ *	Locking: caller holds tty_port->mutex
+ *	Interrupts: caller dependent.
+ *	This call must not sleep
+ *
+ * @set_ldisc: ``void ()(struct uart_port *port, struct ktermios *termios)``
+ *
+ *	Notifier for discipline change. See
+ *	Documentation/driver-api/tty/tty_ldisc.rst.
+ *
+ *	Locking: caller holds tty_port->mutex
+ *
+ * @pm: ``void ()(struct uart_port *port, unsigned int state,
+ *		 unsigned int oldstate)``
+ *
+ *	Perform any power management related activities on the specified @port.
+ *	@state indicates the new state (defined by enum uart_pm_state),
+ *	@oldstate indicates the previous state.
+ *
+ *	This function should not be used to grab any resources.
+ *
+ *	This will be called when the @port is initially opened and finally
+ *	closed, except when the @port is also the system console. This will
+ *	occur even if %CONFIG_PM is not set.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @type: ``const char *()(struct uart_port *port)``
+ *
+ *	Return a pointer to a string constant describing the specified @port,
+ *	or return %NULL, in which case the string 'unknown' is substituted.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @release_port: ``void ()(struct uart_port *port)``
+ *
+ *	Release any memory and IO region resources currently in use by the
+ *	@port.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @request_port: ``int ()(struct uart_port *port)``
+ *
+ *	Request any memory and IO region resources required by the port. If any
+ *	fail, no resources should be registered when this function returns, and
+ *	it should return -%EBUSY on failure.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @config_port: ``void ()(struct uart_port *port, int type)``
+ *
+ *	Perform any autoconfiguration steps required for the @port. @type
+ *	contains a bit mask of the required configuration. %UART_CONFIG_TYPE
+ *	indicates that the port requires detection and identification.
+ *	@port->type should be set to the type found, or %PORT_UNKNOWN if no
+ *	port was detected.
+ *
+ *	%UART_CONFIG_IRQ indicates autoconfiguration of the interrupt signal,
+ *	which should be probed using standard kernel autoprobing techniques.
+ *	This is not necessary on platforms where ports have interrupts
+ *	internally hard wired (eg, system on a chip implementations).
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @verify_port: ``int ()(struct uart_port *port,
+ *			struct serial_struct *serinfo)``
+ *
+ *	Verify the new serial port information contained within @serinfo is
+ *	suitable for this port type.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @ioctl: ``int ()(struct uart_port *port, unsigned int cmd,
+ *		unsigned long arg)``
+ *
+ *	Perform any port specific IOCTLs. IOCTL commands must be defined using
+ *	the standard numbering system found in <asm/ioctl.h>.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *
+ * @poll_init: ``int ()(struct uart_port *port)``
+ *
+ *	Called by kgdb to perform the minimal hardware initialization needed to
+ *	support @poll_put_char() and @poll_get_char(). Unlike @startup(), this
+ *	should not request interrupts.
+ *
+ *	Locking: %tty_mutex and tty_port->mutex taken.
+ *	Interrupts: n/a.
+ *
+ * @poll_put_char: ``void ()(struct uart_port *port, unsigned char ch)``
+ *
+ *	Called by kgdb to write a single character @ch directly to the serial
+ *	@port. It can and should block until there is space in the TX FIFO.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *	This call must not sleep
+ *
+ * @poll_get_char: ``int ()(struct uart_port *port)``
+ *
+ *	Called by kgdb to read a single character directly from the serial
+ *	port. If data is available, it should be returned; otherwise the
+ *	function should return %NO_POLL_CHAR immediately.
+ *
+ *	Locking: none.
+ *	Interrupts: caller dependent.
+ *	This call must not sleep
  */
 struct uart_ops {
 	unsigned int	(*tx_empty)(struct uart_port *);
@@ -56,22 +383,8 @@ struct uart_ops {
 	void		(*set_ldisc)(struct uart_port *, struct ktermios *);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned int oldstate);
-
-	/*
-	 * Return a string describing the type of the port
-	 */
 	const char	*(*type)(struct uart_port *);
-
-	/*
-	 * Release IO and memory resources used by the port.
-	 * This includes iounmap if necessary.
-	 */
 	void		(*release_port)(struct uart_port *);
-
-	/*
-	 * Request IO and memory resources used by the port.
-	 * This includes iomapping the port if necessary.
-	 */
 	int		(*request_port)(struct uart_port *);
 	void		(*config_port)(struct uart_port *, int);
 	int		(*verify_port)(struct uart_port *, struct serial_struct *);
-- 
2.37.1

