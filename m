Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357DB4EE149
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiCaTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiCaTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27F2E1B4E8B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648753445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbkE8i64mGZPnA7FSz8l/wZ93NIfJv9fPsLSTGyPeKw=;
        b=RH6EfmqgzemCdeE5FeQkeGazs2x4i2gGfFPYoe1Crr/h3oGgNi4pOdxi14jjSlPblppeFi
        Dc30jY0fW5qVYcszVRcHni6z2vzP9UshOSHHw2L3AbhFvhvFaO3E4fDiwjSEtVAqp40jt5
        lx0xVbjmMZlKmZS620BjuPGI293sd2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-6M546FmFM2KWSBfXhBpSBQ-1; Thu, 31 Mar 2022 15:03:59 -0400
X-MC-Unique: 6M546FmFM2KWSBfXhBpSBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9923E85A5A8;
        Thu, 31 Mar 2022 19:03:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.35.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9AE753C9;
        Thu, 31 Mar 2022 19:03:53 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
Date:   Thu, 31 Mar 2022 16:02:55 -0300
Message-Id: <20220331190257.101781-2-wander@redhat.com>
In-Reply-To: <20220331190257.101781-1-wander@redhat.com>
References: <20220331190257.101781-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I am using a small test app + driver located at [0] for the
problem description. serco is a driver whose write function dispatches
to the serial controller. sertest is a user-mode app that writes n bytes
to the serial console using the serco driver.

While investigating a bug in the RHEL kernel, I noticed that the serial
console throughput is way below the configured speed of 115200 bps in
a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
I got 2.5KB/s.

$ time ./sertest -n 2500 /tmp/serco

real    0m0.997s
user    0m0.000s
sys     0m0.997s

With the help of the function tracer, I then noticed the serial
controller was taking around 410us seconds to dispatch one single byte:

$ trace-cmd record -p function_graph -g serial8250_console_write \
   ./sertest -n 1 /tmp/serco

$ trace-cmd report

            |  serial8250_console_write() {
 0.384 us   |    _raw_spin_lock_irqsave();
 1.836 us   |    io_serial_in();
 1.667 us   |    io_serial_out();
            |    uart_console_write() {
            |      serial8250_console_putchar() {
            |        wait_for_xmitr() {
 1.870 us   |          io_serial_in();
 2.238 us   |        }
 1.737 us   |        io_serial_out();
 4.318 us   |      }
 4.675 us   |    }
            |    wait_for_xmitr() {
 1.635 us   |      io_serial_in();
            |      __const_udelay() {
 1.125 us   |        delay_tsc();
 1.429 us   |      }
...
...
...
 1.683 us   |      io_serial_in();
            |      __const_udelay() {
 1.248 us   |        delay_tsc();
 1.486 us   |      }
 1.671 us   |      io_serial_in();
 411.342 us |    }

In another machine, I measured a throughput of 11.5KB/s, with the serial
controller taking between 80-90us to send each byte. That matches the
expected throughput for a configuration of 115200 bps.

This patch changes the serial8250_console_write to use the 16550 fifo
if available. In my benchmarks I got around 25% improvement in the slow
machine, and no performance penalty in the fast machine.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 68 ++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 318af6f13605..8f7eba5e71cf 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2077,10 +2077,7 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-/*
- *	Wait for transmitter & holding register to empty
- */
-static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+static void wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2097,6 +2094,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+}
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+{
+	unsigned int tmout;
+
+	wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
@@ -3332,6 +3339,35 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 }
 
+/*
+ * Print a string to the serial port using the device FIFO
+ *
+ * It sends fifosize bytes and then waits for the fifo
+ * to get empty.
+ */
+static void serial8250_console_fifo_write(struct uart_8250_port *up,
+					  const char *s, unsigned int count)
+{
+	int i;
+	const char *end = s + count;
+	unsigned int fifosize = up->tx_loadsz;
+	bool cr_sent = false;
+
+	while (s != end) {
+		wait_for_lsr(up, UART_LSR_THRE);
+
+		for (i = 0; i < fifosize && s != end; ++i) {
+			if (*s == '\n' && !cr_sent) {
+				serial_out(up, UART_TX, '\r');
+				cr_sent = true;
+			} else {
+				serial_out(up, UART_TX, *s++);
+				cr_sent = false;
+			}
+		}
+	}
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -3347,7 +3383,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
-	unsigned int ier;
+	unsigned int ier, use_fifo;
 	int locked = 1;
 
 	touch_nmi_watchdog();
@@ -3379,7 +3415,27 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
-	uart_console_write(port, s, count, serial8250_console_putchar);
+	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
+		/*
+		 * BCM283x requires to check the fifo
+		 * after each byte.
+		 */
+		!(up->capabilities & UART_CAP_MINI) &&
+		up->tx_loadsz > 1 &&
+		(up->fcr & UART_FCR_ENABLE_FIFO) &&
+		port-state &&
+		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
+		/*
+		 * After we put a data in the fifo, the controller will send
+		 * it regardless of the CTS state. Therefore, only use fifo
+		 * if we don't use control flow.
+		 */
+		!(up->port.flags & UPF_CONS_FLOW);
+
+	if (likely(use_fifo))
+		serial8250_console_fifo_write(up, s, count);
+	else
+		uart_console_write(port, s, count, serial8250_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.35.1

