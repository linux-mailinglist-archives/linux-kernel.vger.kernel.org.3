Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99155328A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350968AbiFUMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350812AbiFUMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:50:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2ED2A714;
        Tue, 21 Jun 2022 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815835; x=1687351835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jphQvuNWUDLk1nLZ5YpCob7RfIIJgmVazyGz6XAGpTk=;
  b=UeRJHhMK/gybZNqB2FSrb18X3qmoi5L9jqpm6UZm54au3VViNfZ3hfeo
   h9oH+IuSjd7XY4TCsG3NhJdmhyNv5blmOc2OlVZ3zrSDsQMaKPgY1+Qxj
   1h+46GYoSUKm4ER5zwPRrZ5R7pUxtw2dQHQCJEDdwJVFCnq8XJttuauwK
   LKRMYLf1n/iU5VIQaUmjJWrPil0Pcsx3DRRJNqSGFl6WCg6EP3zATlwYN
   nxmb78GliEdqtBh+USvSc3fLHTGMzL7YyoudiRTFFgwUO1HMkvRI3x9b1
   MisEdv+dacLRn9r7Nb6kcSG5nzcBu3oCQVZ8xRqKboDpNhZVNz3uALNRl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341793021"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341793021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833561596"
Received: from zjeffery-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, sparclinux@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
Date:   Tue, 21 Jun 2022 15:49:58 +0300
Message-Id: <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per file BOTH_EMPTY defines are littering our source code here and
there. Define once in serial.h and create helper for the check
too.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/ath79/early_printk.c           |  9 +++++----
 drivers/accessibility/speakup/serialio.h |  3 +--
 drivers/tty/serial/8250/8250_early.c     |  4 +---
 drivers/tty/serial/8250/8250_port.c      | 12 +++++-------
 drivers/tty/serial/omap-serial.c         |  7 +++----
 drivers/tty/serial/pch_uart.c            |  7 +++----
 drivers/tty/serial/pxa.c                 |  5 ++---
 drivers/tty/serial/sunsu.c               |  4 +---
 drivers/tty/serial/vr41xx_siu.c          |  4 +---
 include/linux/serial.h                   |  9 +++++++++
 10 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index 8751d067f98f..f6d02b425a10 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -8,6 +8,7 @@
 
 #include <linux/io.h>
 #include <linux/errno.h>
+#include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <asm/addrspace.h>
 #include <asm/setup.h>
@@ -29,15 +30,15 @@ static inline void prom_putchar_wait(void __iomem *reg, u32 mask, u32 val)
 	} while (1);
 }
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 static void prom_putchar_ar71xx(char ch)
 {
 	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
 
-	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
+			  UART_LSR_BOTH_EMPTY);
 	__raw_writel((unsigned char)ch, base + UART_TX * 4);
-	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
+			  UART_LSR_BOTH_EMPTY);
 }
 
 static void prom_putchar_ar933x(char ch)
diff --git a/drivers/accessibility/speakup/serialio.h b/drivers/accessibility/speakup/serialio.h
index 6f8f86f161bb..b4f9a1925b81 100644
--- a/drivers/accessibility/speakup/serialio.h
+++ b/drivers/accessibility/speakup/serialio.h
@@ -33,9 +33,8 @@ struct old_serial_port {
 #define NUM_DISABLE_TIMEOUTS 3
 /* buffer timeout in ms */
 #define SPK_TIMEOUT 100
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
 #define spk_serial_tx_busy() \
-	((inb(speakup_info.port_tts + UART_LSR) & BOTH_EMPTY) != BOTH_EMPTY)
+	(!uart_lsr_tx_empty(inb(speakup_info.port_tts + UART_LSR)))
 
 #endif
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e52585064565..f271becfc46c 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -84,8 +84,6 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 	}
 }
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 static void serial_putc(struct uart_port *port, unsigned char c)
 {
 	unsigned int status;
@@ -94,7 +92,7 @@ static void serial_putc(struct uart_port *port, unsigned char c)
 
 	for (;;) {
 		status = serial8250_early_in(port, UART_LSR);
-		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
+		if (uart_lsr_tx_empty(status))
 			break;
 		cpu_relax();
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 432742a567b6..647bd351e611 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -50,8 +50,6 @@
 #define DEBUG_AUTOCONF(fmt...)	do { } while (0)
 #endif
 
-#define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
-
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
@@ -1841,7 +1839,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 		if (uart_circ_empty(xmit))
 			break;
 		if ((up->capabilities & UART_CAP_HFIFO) &&
-		    (serial_in(up, UART_LSR) & BOTH_EMPTY) != BOTH_EMPTY)
+		    !uart_lsr_tx_empty(serial_in(up, UART_LSR)))
 			break;
 		/* The BCM2835 MINI UART THRE bit is really a not-full bit. */
 		if ((up->capabilities & UART_CAP_MINI) &&
@@ -2001,7 +1999,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	serial8250_rpm_put(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return uart_lsr_tx_empty(lsr) ? TIOCSER_TEMT : 0;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
@@ -2149,7 +2147,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	else
 		serial_port_out(port, UART_IER, 0);
 
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
 	 *	Send the character out.
 	 */
@@ -2159,7 +2157,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
 	serial8250_rpm_put(up);
 }
@@ -3429,7 +3427,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up, BOTH_EMPTY);
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 98622c35d896..52cb1a68b053 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -1102,8 +1103,6 @@ serial_omap_type(struct uart_port *port)
 	return up->name;
 }
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)
 {
 	unsigned int status, tmout = 10000;
@@ -1118,7 +1117,7 @@ static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
@@ -1186,7 +1185,7 @@ static void omap_serial_early_putc(struct uart_port *port, unsigned char c)
 
 	for (;;) {
 		status = omap_serial_early_in(port, UART_LSR);
-		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
+		if (uart_lsr_tx_empty(status))
 			break;
 		cpu_relax();
 	}
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 3b26524d48e3..8a9065e4a903 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -3,6 +3,7 @@
  *Copyright (C) 2011 LAPIS Semiconductor Co., Ltd.
  */
 #include <linux/kernel.h>
+#include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -189,8 +190,6 @@ enum {
 #define PCH_UART_HAL_LOOP		(PCH_UART_MCR_LOOP)
 #define PCH_UART_HAL_AFE		(PCH_UART_MCR_AFE)
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 #define DEFAULT_UARTCLK   1843200 /*   1.8432 MHz */
 #define CMITC_UARTCLK   192000000 /* 192.0000 MHz */
 #define FRI2_64_UARTCLK  64000000 /*  64.0000 MHz */
@@ -1516,7 +1515,7 @@ static void pch_uart_put_poll_char(struct uart_port *port,
 	 * Finally, wait for transmitter to become empty
 	 * and restore the IER
 	 */
-	wait_for_xmitr(priv, BOTH_EMPTY);
+	wait_for_xmitr(priv, UART_LSR_BOTH_EMPTY);
 	iowrite8(ier, priv->membase + UART_IER);
 }
 #endif /* CONFIG_CONSOLE_POLL */
@@ -1602,7 +1601,7 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(priv, BOTH_EMPTY);
+	wait_for_xmitr(priv, UART_LSR_BOTH_EMPTY);
 	iowrite8(ier, priv->membase + UART_IER);
 
 	if (port_locked)
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index e80ba8e10407..9309ffd87c8e 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
+#include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <linux/circ_buf.h>
 #include <linux/delay.h>
@@ -575,8 +576,6 @@ static struct uart_driver serial_pxa_reg;
 
 #ifdef CONFIG_SERIAL_PXA_CONSOLE
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 /*
  *	Wait for transmitter & holding register to empty
  */
@@ -594,7 +593,7 @@ static void wait_for_xmitr(struct uart_pxa_port *up)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index fff50b5b82eb..84d545e5a8c7 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1249,8 +1249,6 @@ static int sunsu_kbd_ms_init(struct uart_sunsu_port *up)
 
 #ifdef CONFIG_SERIAL_SUNSU_CONSOLE
 
-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
 /*
  *	Wait for transmitter & holding register to empty
  */
@@ -1268,7 +1266,7 @@ static void wait_for_xmitr(struct uart_sunsu_port *up)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index e0bf003ca3a1..1ba689a81abd 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -703,8 +703,6 @@ static int siu_init_ports(struct platform_device *pdev)
 
 #ifdef CONFIG_SERIAL_VR41XX_CONSOLE
 
-#define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
-
 static void wait_for_xmitr(struct uart_port *port)
 {
 	int timeout = 10000;
@@ -715,7 +713,7 @@ static void wait_for_xmitr(struct uart_port *port)
 		if (lsr & UART_LSR_BI)
 			lsr_break_flag[port->line] = UART_LSR_BI;
 
-		if ((lsr & BOTH_EMPTY) == BOTH_EMPTY)
+		if (uart_lsr_tx_empty(lsr))
 			break;
 	} while (timeout-- > 0);
 
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 70a9866e4abb..3d6fe3ef92cf 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -10,10 +10,19 @@
 #define _LINUX_SERIAL_H
 
 #include <uapi/linux/serial.h>
+#include <uapi/linux/serial_reg.h>
 
 /* Helper for dealing with UART_LCR_WLEN* defines */
 #define UART_LCR_WLEN(x)	((x) - 5)
 
+/* FIFO and shifting register empty */
+#define UART_LSR_BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
+
+static inline bool uart_lsr_tx_empty(u16 lsr)
+{
+	return (lsr & UART_LSR_BOTH_EMPTY) == UART_LSR_BOTH_EMPTY;
+}
+
 /*
  * Counters of the input lines (CTS, DSR, RI, CD) interrupts
  */
-- 
2.30.2

