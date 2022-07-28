Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9E583873
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiG1GLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiG1GK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:10:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9031356;
        Wed, 27 Jul 2022 23:10:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E3B6334BBA;
        Thu, 28 Jul 2022 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XQuxJINSr8IzME74nr/Ktk1WRgB/GcLBhw4EaRBaus=;
        b=MyrnTEMTUqt8Fe5SLV4DlWAysg4I7FIe3ikqzv9yA279btVmLdUTqcEsPikYC640kAyioL
        Mn4tnVZSDO+Wp5WWs0nlBiajJ3sMKtz9/z+YOC/tNeALq6//jutGZyY3gJcaA6uihOzCiZ
        43v63zlseQ5WUyhj+nor9n04tSa4ypo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XQuxJINSr8IzME74nr/Ktk1WRgB/GcLBhw4EaRBaus=;
        b=1FPjygj5MmQfPONTg+6tV23FvtOKRIfZLxjZjz2LWszuel7QBuK5O5myKID7NOeqOFQODJ
        dJc1Di4fDm5tYvDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1E382C142;
        Thu, 28 Jul 2022 06:10:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/6] Documentation: serial: dedup kernel-doc for uart functions
Date:   Thu, 28 Jul 2022 08:10:52 +0200
Message-Id: <20220728061056.20799-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728061056.20799-1-jslaby@suse.cz>
References: <20220728061056.20799-1-jslaby@suse.cz>
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

Some of the serial (uart_*) functions are documented twice. Once as
kernel-doc along their sources and once in Documentation. So deduplicate
these texts, merge them into kernel-doc in the sources, and link them
using kernel-doc: from the Documentation.

To be properly linked and rendered, tabulators had to be removed from
the comments.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst |  84 +-----------
 drivers/tty/serial/serial_core.c           | 141 ++++++++++++---------
 2 files changed, 87 insertions(+), 138 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index cb0ec6db4f1e..ac9620e97f4b 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -69,85 +69,11 @@ uart_ops
 Other functions
 ---------------
 
-uart_update_timeout(port,cflag,baud)
-	Update the frame timing information according to the number of bits,
-	parity, stop bits and baud rate. The FIFO drain timeout is derived
-	from the frame timing information.
-
-	Locking: caller is expected to take port->lock
-
-	Interrupts: n/a
-
-uart_get_baud_rate(port,termios,old,min,max)
-	Return the numeric baud rate for the specified termios, taking
-	account of the special 38400 baud "kludge".  The B0 baud rate
-	is mapped to 9600 baud.
-
-	If the baud rate is not within min..max, then if old is non-NULL,
-	the original baud rate will be tried.  If that exceeds the
-	min..max constraint, 9600 baud will be returned.  termios will
-	be updated to the baud rate in use.
-
-	Note: min..max must always allow 9600 baud to be selected.
-
-	Locking: caller dependent.
-
-	Interrupts: n/a
-
-uart_get_divisor(port,baud)
-	Return the divisor (baud_base / baud) for the specified baud
-	rate, appropriately rounded.
-
-	If 38400 baud and custom divisor is selected, return the
-	custom divisor instead.
-
-	Locking: caller dependent.
-
-	Interrupts: n/a
-
-uart_match_port(port1,port2)
-	This utility function can be used to determine whether two
-	uart_port structures describe the same port.
-
-	Locking: n/a
-
-	Interrupts: n/a
-
-uart_write_wakeup(port)
-	A driver is expected to call this function when the number of
-	characters in the transmit buffer have dropped below a threshold.
-
-	Locking: port->lock should be held.
-
-	Interrupts: n/a
-
-uart_register_driver(drv)
-	Register a uart driver with the core driver.  We in turn register
-	with the tty layer, and initialise the core driver per-port state.
-
-	drv->port should be NULL, and the per-port structures should be
-	registered using uart_add_one_port after this call has succeeded.
-
-	Locking: none
-
-	Interrupts: enabled
-
-uart_unregister_driver()
-	Remove all references to a driver from the core driver.  The low
-	level driver must have removed all its ports via the
-	uart_remove_one_port() if it registered them with uart_add_one_port().
-
-	Locking: none
-
-	Interrupts: enabled
-
-**uart_suspend_port()**
-
-**uart_resume_port()**
-
-**uart_add_one_port()**
-
-**uart_remove_one_port()**
+.. kernel-doc:: drivers/tty/serial/serial_core.c
+   :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor
+           uart_match_port uart_write_wakeup uart_register_driver
+           uart_unregister_driver uart_suspend_port uart_resume_port
+           uart_add_one_port uart_remove_one_port
 
 Other notes
 -----------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ae32bdb87235..810dba0b92e3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -97,9 +97,16 @@ static inline struct uart_port *uart_port_check(struct uart_state *state)
 	return state->uart_port;
 }
 
-/*
- * This routine is used by the interrupt handler to schedule processing in
- * the software interrupt portion of the driver.
+/**
+ * uart_write_wakeup - schedule write processing
+ * @port: port to be processed
+ *
+ * This routine is used by the interrupt handler to schedule processing in the
+ * software interrupt portion of the driver. A driver is expected to call this
+ * function when the number of characters in the transmit buffer have dropped
+ * below a threshold.
+ *
+ * Locking: @port->lock should be held
  */
 void uart_write_wakeup(struct uart_port *port)
 {
@@ -327,14 +334,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 }
 
 /**
- *	uart_update_timeout - update per-port frame timing information.
- *	@port:  uart_port structure describing the port
- *	@cflag: termios cflag value
- *	@baud:  speed of the port
+ * uart_update_timeout - update per-port frame timing information
+ * @port: uart_port structure describing the port
+ * @cflag: termios cflag value
+ * @baud: speed of the port
  *
- *	Set the port frame timing information from which the FIFO timeout
- *	value is derived. The @cflag value should reflect the actual hardware
- *	settings.
+ * Set the @port frame timing information from which the FIFO timeout value is
+ * derived. The @cflag value should reflect the actual hardware settings as
+ * number of bits, parity, stop bits and baud rate is taken into account here.
+ *
+ * Locking: caller is expected to take @port->lock
  */
 void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
@@ -349,23 +358,25 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 EXPORT_SYMBOL(uart_update_timeout);
 
 /**
- *	uart_get_baud_rate - return baud rate for a particular port
- *	@port: uart_port structure describing the port in question.
- *	@termios: desired termios settings.
- *	@old: old termios (or NULL)
- *	@min: minimum acceptable baud rate
- *	@max: maximum acceptable baud rate
+ * uart_get_baud_rate - return baud rate for a particular port
+ * @port: uart_port structure describing the port in question.
+ * @termios: desired termios settings
+ * @old: old termios (or %NULL)
+ * @min: minimum acceptable baud rate
+ * @max: maximum acceptable baud rate
+ *
+ * Decode the termios structure into a numeric baud rate, taking account of the
+ * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
+ * baud.
  *
- *	Decode the termios structure into a numeric baud rate,
- *	taking account of the magic 38400 baud rate (with spd_*
- *	flags), and mapping the %B0 rate to 9600 baud.
+ * If the new baud rate is invalid, try the @old termios setting. If it's still
+ * invalid, we try 9600 baud.
  *
- *	If the new baud rate is invalid, try the old termios setting.
- *	If it's still invalid, we try 9600 baud.
+ * The @termios structure is updated to reflect the baud rate we're actually
+ * going to be using. Don't do this for the case where B0 is requested ("hang
+ * up").
  *
- *	Update the @termios structure to reflect the baud rate
- *	we're actually going to be using. Don't do this for the case
- *	where B0 is requested ("hang up").
+ * Locking: caller dependent
  */
 unsigned int
 uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
@@ -450,11 +461,17 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 EXPORT_SYMBOL(uart_get_baud_rate);
 
 /**
- *	uart_get_divisor - return uart clock divisor
- *	@port: uart_port structure describing the port.
- *	@baud: desired baud rate
+ * uart_get_divisor - return uart clock divisor
+ * @port: uart_port structure describing the port
+ * @baud: desired baud rate
+ *
+ * Calculate the divisor (baud_base / baud) for the specified @baud,
+ * appropriately rounded.
  *
- *	Calculate the uart clock divisor for the port.
+ * If 38400 baud and custom divisor is selected, return the custom divisor
+ * instead.
+ *
+ * Locking: caller dependent
  */
 unsigned int
 uart_get_divisor(struct uart_port *port, unsigned int baud)
@@ -2678,17 +2695,19 @@ static const struct tty_port_operations uart_port_ops = {
 };
 
 /**
- *	uart_register_driver - register a driver with the uart core layer
- *	@drv: low level driver structure
+ * uart_register_driver - register a driver with the uart core layer
+ * @drv: low level driver structure
+ *
+ * Register a uart driver with the core driver. We in turn register with the
+ * tty layer, and initialise the core driver per-port state.
  *
- *	Register a uart driver with the core driver.  We in turn register
- *	with the tty layer, and initialise the core driver per-port state.
+ * We have a proc file in /proc/tty/driver which is named after the normal
+ * driver.
  *
- *	We have a proc file in /proc/tty/driver which is named after the
- *	normal driver.
+ * @drv->port should be %NULL, and the per-port structures should be registered
+ * using uart_add_one_port() after this call has succeeded.
  *
- *	drv->port should be NULL, and the per-port structures should be
- *	registered using uart_add_one_port after this call has succeeded.
+ * Locking: none, Interrupts: enabled
  */
 int uart_register_driver(struct uart_driver *drv)
 {
@@ -2752,13 +2771,14 @@ int uart_register_driver(struct uart_driver *drv)
 EXPORT_SYMBOL(uart_register_driver);
 
 /**
- *	uart_unregister_driver - remove a driver from the uart core layer
- *	@drv: low level driver structure
+ * uart_unregister_driver - remove a driver from the uart core layer
+ * @drv: low level driver structure
+ *
+ * Remove all references to a driver from the core driver. The low level
+ * driver must have removed all its ports via the uart_remove_one_port() if it
+ * registered them with uart_add_one_port(). (I.e. @drv->port is %NULL.)
  *
- *	Remove all references to a driver from the core driver.  The low
- *	level driver must have removed all its ports via the
- *	uart_remove_one_port() if it registered them with uart_add_one_port().
- *	(ie, drv->port == NULL)
+ * Locking: none, Interrupts: enabled
  */
 void uart_unregister_driver(struct uart_driver *drv)
 {
@@ -3007,16 +3027,15 @@ static const struct attribute_group tty_dev_attr_group = {
 };
 
 /**
- *	uart_add_one_port - attach a driver-defined port structure
- *	@drv: pointer to the uart low level driver structure for this port
- *	@uport: uart port structure to use for this port.
+ * uart_add_one_port - attach a driver-defined port structure
+ * @drv: pointer to the uart low level driver structure for this port
+ * @uport: uart port structure to use for this port.
  *
- *	Context: task context, might sleep
+ * Context: task context, might sleep
  *
- *	This allows the driver to register its own uart_port structure
- *	with the core driver.  The main purpose is to allow the low
- *	level uart drivers to expand uart_port, rather than having yet
- *	more levels of structures.
+ * This allows the driver @drv to register its own uart_port structure with the
+ * core driver. The main purpose is to allow the low level uart drivers to
+ * expand uart_port, rather than having yet more levels of structures.
  */
 int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
@@ -3111,15 +3130,14 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 EXPORT_SYMBOL(uart_add_one_port);
 
 /**
- *	uart_remove_one_port - detach a driver defined port structure
- *	@drv: pointer to the uart low level driver structure for this port
- *	@uport: uart port structure for this port
+ * uart_remove_one_port - detach a driver defined port structure
+ * @drv: pointer to the uart low level driver structure for this port
+ * @uport: uart port structure for this port
  *
- *	Context: task context, might sleep
+ * Context: task context, might sleep
  *
- *	This unhooks (and hangs up) the specified port structure from the
- *	core driver.  No further calls will be made to the low-level code
- *	for this port.
+ * This unhooks (and hangs up) the specified port structure from the core
+ * driver. No further calls will be made to the low-level code for this port.
  */
 int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
@@ -3191,8 +3209,13 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
-/*
- *	Are the two ports equivalent?
+/**
+ * uart_match_port - are the two ports equivalent?
+ * @port1: first port
+ * @port2: second port
+ *
+ * This utility function can be used to determine whether two uart_port
+ * structures describe the same port.
  */
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2)
-- 
2.37.1

