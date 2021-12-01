Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE413464BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbhLAKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348790AbhLAKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:50:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038EC061756;
        Wed,  1 Dec 2021 02:46:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so20701277pju.3;
        Wed, 01 Dec 2021 02:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKQUO/tBOxm1A05++qJyc844uQydplTqGVonjT20DvA=;
        b=BhEpZEsZsHvBpApEKxJxmP7sDlFS5Yu4POVgRxXuWYOvkwJpySEKwgPAzfmQlukuv5
         9d31I4Bee6Z7nOKvmmiVEpsO8x6gyGXvu735eEa8mQLqx1Pg+fOQ8bZa/g8p3hx7U10O
         gFO7/PsaenFgSNHRwFK3qOG7SuGU8lqmQ+LE6pFDzkV2yb836IBjDEdFsIggBFy+mSOn
         PGqwBjvYlylE3Oj+hqVS2sFLRO8So+cWAv4dKH7CwCALzOL6HjyXKyDdRcsDPoQE0VkF
         D4KMiABS8ERiD4aveSZfFP9rVnR5ZxGxlo7rOIBWr25hwmoKgBO6ejdr7X6uCdWWKdeo
         ScaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKQUO/tBOxm1A05++qJyc844uQydplTqGVonjT20DvA=;
        b=07HPDa7rYCnXODo6hGG52kUMfBQoYdkLV+wbu1crHDnb4GaeKyjgSCVdiS2QufQed0
         ueLg6BA5sdfBHCCjVyyrjH06So2QgdB9n6n5y5OHq1E2qhxByTc6UVIf3DBJq2oyW0yt
         pXg4er6xnYL6DcNR/2w3vWBPNmXoUlsrS/LX23FBocUyF2be1NnmnXkqXhAoyTri0Jc4
         l2nCJmgqr8hJaMAdMuOsmJYSY2UHJesRj3AzJl6Vl4LvWVoEFi3SkhNKFw6aUL3jbmcc
         QjLpzeTk3O8urZ+4qfRZaTs/1MPmCRgXh0tLwVIrMW/X+b83YZybojw+8Rc6IsU5XG/t
         K7rQ==
X-Gm-Message-State: AOAM530kd5FT5DEl/EG3uAj+B+eLDOI3krnNMbfKQXmkutbuBWiir0ba
        tYPvr78ZdGMPtH/a9+nTfJ4=
X-Google-Smtp-Source: ABdhPJxpj0uBwlK3IBq8q7/sfXcAbLp//PeRhJa+xZv+mT8u681q4FQpM3yPUE+E2n8DQkPcqTcKlw==
X-Received: by 2002:a17:903:408d:b0:142:22f1:5886 with SMTP id z13-20020a170903408d00b0014222f15886mr6629491plc.34.1638355611903;
        Wed, 01 Dec 2021 02:46:51 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id f22sm26395318pfj.49.2021.12.01.02.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:46:51 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v4 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Date:   Wed,  1 Dec 2021 18:46:44 +0800
Message-Id: <1638355604-24002-3-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v4:
 - Addressed all comments from Andy Shevchenko except pm runtime function.

 MAINTAINERS                       |   1 +
 drivers/tty/serial/Kconfig        |  23 ++
 drivers/tty/serial/Makefile       |   1 +
 drivers/tty/serial/sunplus-uart.c | 848 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 873 insertions(+)
 create mode 100644 drivers/tty/serial/sunplus-uart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f2ee40c..65681ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS UART DRIVER
 M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+F:	drivers/tty/serial/sunplus-uart.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 131a6a5..ffdcf40 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1561,6 +1561,29 @@ config SERIAL_LITEUART_CONSOLE
 	  and warnings and which allows logins in single user mode).
 	  Otherwise, say 'N'.
 
+config SERIAL_SUNPLUS
+	tristate "Sunplus UART support"
+	depends on OF || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  Select this option if you would like to use Sunplus serial port on
+	  Sunplus SoC SP7021.
+	  If you enable this option, Sunplus serial ports in the system will
+	  be registered as ttySUPx.
+
+config SERIAL_SUNPLUS_CONSOLE
+	bool "Console on Sunplus UART"
+	depends on SERIAL_SUNPLUS
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Select this option if you would like to use a Sunplus UART as the
+	  system console.
+	  Even if you say Y here, the currently visible virtual console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttySUPx".
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7da0856..61cc8de 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
+obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
new file mode 100644
index 0000000..9395207
--- /dev/null
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -0,0 +1,848 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sunplus SoC UART driver
+ *
+ * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
+ * Tony Huang <tony.huang@sunplus.com>
+ * Wells Lu <wells.lu@sunplus.com>
+ */
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/serial_core.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <asm/irq.h>
+
+/* Register offsets */
+#define SUP_UART_DATA			0x00
+#define SUP_UART_LSR			0x04
+#define SUP_UART_MSR			0x08
+#define SUP_UART_LCR			0x0C
+#define SUP_UART_MCR			0x10
+#define SUP_UART_DIV_L			0x14
+#define SUP_UART_DIV_H			0x18
+#define SUP_UART_ISC			0x1C
+#define SUP_UART_TX_RESIDUE		0x20
+#define SUP_UART_RX_RESIDUE		0x24
+
+/* Line Status Register bits */
+#define SUP_UART_LSR_TXE		BIT(6) /* tx empty */
+#define SUP_UART_LSR_BC			BIT(5) /* break condition status */
+#define SUP_UART_LSR_FE			BIT(4) /* frame error status */
+#define SUP_UART_LSR_OE			BIT(3) /* overrun error status */
+#define SUP_UART_LSR_PE			BIT(2) /* parity error status */
+#define SUP_UART_LSR_RX			BIT(1) /* 1: receive fifo not empty */
+#define SUP_UART_LSR_TX			BIT(0) /* 1: transmit fifo is not full */
+#define SUP_UART_LSR_TX_NOT_FULL	1
+#define SUP_UART_LSR_BRK_ERROR_BITS	GENMASK(5, 2)
+
+/* Line Control Register bits */
+#define SUP_UART_LCR_BC			BIT(5) /* break condition select */
+#define SUP_UART_LCR_PR			BIT(4) /* parity bit polarity select */
+#define SUP_UART_LCR_PE			BIT(3) /* parity bit enable */
+#define SUP_UART_LCR_ST			BIT(2) /* stop bits select */
+#define SUP_UART_LCR_WL5		0x00 /*  word length 5 */
+#define SUP_UART_LCR_WL6		0x01 /*  word length 6 */
+#define SUP_UART_LCR_WL7		0x02 /*  word length 7 */
+#define SUP_UART_LCR_WL8		0x03 /*  word length 8 (default) */
+
+/* Modem Control Register bits */
+#define SUP_UART_MCR_LB			BIT(4) /* Loopback mode */
+#define SUP_UART_MCR_RI			BIT(3) /* ring indicator */
+#define SUP_UART_MCR_DCD		BIT(2) /* data carrier detect */
+#define SUP_UART_MCR_RTS		BIT(1) /* request to send */
+#define SUP_UART_MCR_DTS		BIT(0) /* data terminal ready */
+
+/* Interrupt Status/Control Register bits */
+#define SUP_UART_ISC_RXM		BIT(5) /* RX interrupt enable */
+#define SUP_UART_ISC_TXM		BIT(4) /* TX interrupt enable */
+#define SUP_UART_ISC_RX			BIT(1) /* RX interrupt status */
+#define SUP_UART_ISC_TX			BIT(0) /* TX interrupt status */
+
+#define SUP_DUMMY_READ			BIT(16) /* drop bytes received on a !CREAD port */
+#define UART_AUTOSUSPEND_TIMEOUT	3000
+#define SUP_UART_NR			5
+
+struct sunplus_uart_port {
+	struct uart_port port;
+	struct clk *clk;
+	struct reset_control *rstc;
+};
+
+static inline struct sunplus_uart_port *to_sunplus_uart(struct uart_port *port)
+{
+	return container_of(port, struct sunplus_uart_port, port);
+}
+
+static inline void sp_uart_put_char(struct uart_port *port, unsigned int ch)
+{
+	writel(ch, port->membase + SUP_UART_DATA);
+}
+
+static inline u32 sunplus_tx_buf_not_full(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+
+	return ((lsr & SUP_UART_LSR_TX) ? SUP_UART_LSR_TX_NOT_FULL : 0);
+}
+
+static unsigned int sunplus_tx_empty(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+
+	return ((lsr & SUP_UART_LSR_TXE) ? TIOCSER_TEMT : 0);
+}
+
+static void sunplus_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	unsigned int mcr = readl(port->membase + SUP_UART_MCR);
+
+	if (mctrl & TIOCM_DTR)
+		mcr |= SUP_UART_MCR_DTS;
+	else
+		mcr &= ~SUP_UART_MCR_DTS;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= SUP_UART_MCR_RTS;
+	else
+		mcr &= ~SUP_UART_MCR_RTS;
+
+	if (mctrl & TIOCM_CAR)
+		mcr |= SUP_UART_MCR_DCD;
+	else
+		mcr &= ~SUP_UART_MCR_DCD;
+
+	if (mctrl & TIOCM_RI)
+		mcr |= SUP_UART_MCR_RI;
+	else
+		mcr &= ~SUP_UART_MCR_RI;
+
+	if (mctrl & TIOCM_LOOP)
+		mcr |= SUP_UART_MCR_LB;
+	else
+		mcr &= ~SUP_UART_MCR_LB;
+
+	writel(mcr, port->membase + SUP_UART_MCR);
+}
+
+static unsigned int sunplus_get_mctrl(struct uart_port *port)
+{
+	unsigned int ret, mcr;
+
+	mcr = readl(port->membase + SUP_UART_MCR);
+
+	if (mcr & SUP_UART_MCR_DTS)
+		ret |= TIOCM_DTR;
+
+	if (mcr & SUP_UART_MCR_RTS)
+		ret |= TIOCM_RTS;
+
+	if (mcr & SUP_UART_MCR_DCD)
+		ret |= TIOCM_CAR;
+
+	if (mcr & SUP_UART_MCR_RI)
+		ret |= TIOCM_RI;
+
+	if (mcr & SUP_UART_MCR_LB)
+		ret |= TIOCM_LOOP;
+
+	return ret;
+}
+
+static void sunplus_stop_tx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SUP_UART_ISC);
+	isc &= ~SUP_UART_ISC_TXM;
+	writel(isc, port->membase + SUP_UART_ISC);
+}
+
+static void sunplus_start_tx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SUP_UART_ISC);
+	isc |= SUP_UART_ISC_TXM;
+	writel(isc, port->membase + SUP_UART_ISC);
+}
+
+static void sunplus_stop_rx(struct uart_port *port)
+{
+	unsigned int isc;
+
+	isc = readl(port->membase + SUP_UART_ISC);
+	isc &= ~SUP_UART_ISC_RXM;
+	writel(isc, port->membase + SUP_UART_ISC);
+}
+
+static void sunplus_break_ctl(struct uart_port *port, int ctl)
+{
+	unsigned long flags;
+	unsigned int lcr;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lcr = readl(port->membase + SUP_UART_LCR);
+
+	if (ctl)
+		lcr |= SUP_UART_LCR_BC;	/* start break */
+	else
+		lcr &= ~SUP_UART_LCR_BC; /* stop break */
+
+	writel(lcr, port->membase + SUP_UART_LCR);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void transmit_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+
+	if (port->x_char) {
+		sp_uart_put_char(port, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		sunplus_stop_tx(port);
+		return;
+	}
+
+	do {
+		sp_uart_put_char(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+
+		if (uart_circ_empty(xmit))
+			break;
+	} while (sunplus_tx_buf_not_full(port));
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sunplus_stop_tx(port);
+}
+
+static void receive_chars(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+	unsigned int ch, flag;
+
+	do {
+		ch = readl(port->membase + SUP_UART_DATA);
+		flag = TTY_NORMAL;
+		port->icount.rx++;
+
+		if (unlikely(lsr & SUP_UART_LSR_BRK_ERROR_BITS)) {
+			if (lsr & SUP_UART_LSR_BC) {
+				lsr &= ~(SUP_UART_LSR_FE | SUP_UART_LSR_PE);
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					goto ignore_char;
+			} else if (lsr & SUP_UART_LSR_PE) {
+				port->icount.parity++;
+			} else if (lsr & SUP_UART_LSR_FE) {
+				port->icount.frame++;
+			}
+
+			if (lsr & SUP_UART_LSR_OE)
+				port->icount.overrun++;
+
+			if (lsr & SUP_UART_LSR_BC)
+				flag = TTY_BREAK;
+			else if (lsr & SUP_UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (lsr & SUP_UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (port->ignore_status_mask & SUP_DUMMY_READ)
+			goto ignore_char;
+
+		if (uart_handle_sysrq_char(port, ch))
+			goto ignore_char;
+
+		uart_insert_char(port, lsr, SUP_UART_LSR_OE, ch, flag);
+
+ignore_char:
+		lsr = readl(port->membase + SUP_UART_LSR);
+	} while (lsr & SUP_UART_LSR_RX);
+
+	tty_flip_buffer_push(&port->state->port);
+}
+
+static irqreturn_t sunplus_uart_irq(int irq, void *args)
+{
+	struct uart_port *port = (struct uart_port *)args;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + SUP_UART_ISC) & SUP_UART_ISC_RX)
+		receive_chars(port);
+
+	if (readl(port->membase + SUP_UART_ISC) & SUP_UART_ISC_TX)
+		transmit_chars(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int sunplus_startup(struct uart_port *port)
+{
+	unsigned int isc;
+	int ret;
+
+#ifdef CONFIG_PM
+	if (!uart_console(port)) {
+		ret = pm_runtime_get_sync(port->dev);
+		if (ret < 0)
+			goto out;
+	}
+#endif
+	ret = request_irq(port->irq, sunplus_uart_irq, 0, "sunplus_uart", port);
+	if (ret)
+		return ret;
+
+	spin_lock_irq(&port->lock);
+
+	isc |= SUP_UART_ISC_RXM;
+	writel(isc, port->membase + SUP_UART_ISC);
+
+	spin_unlock_irq(&port->lock);
+
+#ifdef CONFIG_PM
+	if (!uart_console(port))
+		pm_runtime_put(port->dev);
+
+	return 0;
+out:
+	if (!uart_console(port)) {
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+	}
+#endif
+	return 0;
+}
+
+static void sunplus_shutdown(struct uart_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	writel(0, port->membase + SUP_UART_ISC);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	free_irq(port->irq, port);
+}
+
+static void sunplus_set_termios(struct uart_port *port,
+				struct ktermios *termios,
+				struct ktermios *oldtermios)
+{
+	u32 clk, ext, div, div_l, div_h, baud;
+	u32 lcr, val;
+	unsigned long flags;
+
+	clk = port->uartclk;
+
+	baud = uart_get_baud_rate(port, termios, oldtermios, 0, port->uartclk / 16);
+
+	readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
+				  (val & SUP_UART_LSR_TXE), 1, 10000);
+	/*
+	 * baud rate = uartclk / ((16 * div[15:0] + 1) + div_ext[3:0])
+	 * get target baud rate and uartclk
+	 * auto calculate div and div_ext
+	 * div_h = (div[15:8] >> 8); div_l = (div_ext[3:0] << 12) + div[7:0]
+	 */
+	clk += baud >> 1;
+	div = clk / baud;
+	ext = div & 0x0F;
+	div = (div >> 4) - 1;
+	div_l = (div & 0xFF) | (ext << 12);
+	div_h = div >> 8;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		lcr = SUP_UART_LCR_WL5;
+		break;
+	case CS6:
+		lcr = SUP_UART_LCR_WL6;
+		break;
+	case CS7:
+		lcr = SUP_UART_LCR_WL7;
+		break;
+	default:	/* CS8 */
+		lcr = SUP_UART_LCR_WL8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		lcr |= SUP_UART_LCR_ST;
+
+	if (termios->c_cflag & PARENB) {
+		lcr |= SUP_UART_LCR_PE;
+
+		if (!(termios->c_cflag & PARODD))
+			lcr |= SUP_UART_LCR_PR;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	port->read_status_mask = 0;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= SUP_UART_LSR_PE | SUP_UART_LSR_FE;
+
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |= SUP_UART_LSR_BC;
+
+	/* Characters to ignore */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= SUP_UART_LSR_FE | SUP_UART_LSR_PE;
+
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= SUP_UART_LSR_BC;
+
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= SUP_UART_LSR_OE;
+	}
+
+	/* Ignore all characters if CREAD is not set */
+	if ((termios->c_cflag & CREAD) == 0) {
+		port->ignore_status_mask |= SUP_DUMMY_READ;
+		/* flush rx data FIFO */
+		writel(0, port->membase + SUP_UART_RX_RESIDUE);
+	}
+
+	/* Settings for baud rate divisor and lcr */
+	writel(div_h, port->membase + SUP_UART_DIV_H);
+	writel(div_l, port->membase + SUP_UART_DIV_L);
+	writel(lcr, port->membase + SUP_UART_LCR);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void sunplus_set_ldisc(struct uart_port *port, struct ktermios *termios)
+{
+	int new = termios->c_line;
+
+	if (new == N_PPS)
+		port->flags |= UPF_HARDPPS_CD;
+	else
+		port->flags &= ~UPF_HARDPPS_CD;
+}
+
+static const char *sunplus_type(struct uart_port *port)
+{
+	struct sunplus_uart_port *sup = to_sunplus_uart(port);
+
+	return sup->port.type == PORT_SUNPLUS ? "sunplus_uart" : NULL;
+}
+
+static void sunplus_release_port(struct uart_port *port)
+{
+}
+
+static int sunplus_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sunplus_config_port(struct uart_port *port, int type)
+{
+	if (type & UART_CONFIG_TYPE) {
+		port->type = PORT_SUNPLUS;
+		sunplus_request_port(port);
+	}
+}
+
+static int sunplus_verify_port(struct uart_port *port, struct serial_struct *serial)
+{
+	if (serial->type != PORT_UNKNOWN && serial->type != PORT_SUNPLUS)
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int sunplus_poll_init(struct uart_port *port)
+{
+	return 0;
+}
+
+static void sunplus_poll_put_char(struct uart_port *port, unsigned char data)
+{
+	wait_for_xmitr(port);
+	sp_uart_put_char(port, data);
+}
+
+static int sunplus_poll_get_char(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+
+	if (!(lsr & SUP_UART_LSR_RX))
+		return NO_POLL_CHAR;
+
+	return readl(port->membase + SUP_UART_DATA);
+}
+#endif
+
+static const struct uart_ops sunplus_uart_ops = {
+	.tx_empty		= sunplus_tx_empty,
+	.set_mctrl		= sunplus_set_mctrl,
+	.get_mctrl		= sunplus_get_mctrl,
+	.stop_tx		= sunplus_stop_tx,
+	.start_tx		= sunplus_start_tx,
+	.stop_rx		= sunplus_stop_rx,
+	.break_ctl		= sunplus_break_ctl,
+	.startup		= sunplus_startup,
+	.shutdown		= sunplus_shutdown,
+	.set_termios	= sunplus_set_termios,
+	.set_ldisc		= sunplus_set_ldisc,
+	.type			= sunplus_type,
+	.release_port	= sunplus_release_port,
+	.request_port	= sunplus_request_port,
+	.config_port	= sunplus_config_port,
+	.verify_port	= sunplus_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init		= sunplus_poll_init,
+	.poll_put_char	= sunplus_poll_put_char,
+	.poll_get_char	= sunplus_poll_get_char,
+#endif
+};
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
+
+static inline void wait_for_xmitr(struct uart_port *port)
+{
+	unsigned int val;
+
+	readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
+				  (val & SUP_UART_LSR_TX), 1, 10000);
+}
+
+static void sunplus_uart_console_putchar(struct uart_port *port, int ch)
+{
+	wait_for_xmitr(port);
+	sp_uart_put_char(port, ch);
+}
+
+static void sunplus_uart_console_write(struct console *co,
+				       const char *s,
+				       unsigned int count)
+{
+	unsigned long flags;
+	int locked = 1;
+
+	local_irq_save(flags);
+
+	if (sunplus_console_ports[co->index]->port.sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&sunplus_console_ports[co->index]->port.lock);
+	else
+		spin_lock(&sunplus_console_ports[co->index]->port.lock);
+
+	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
+			   sunplus_uart_console_putchar);
+
+	if (locked)
+		spin_unlock(&sunplus_console_ports[co->index]->port.lock);
+
+	local_irq_restore(flags);
+}
+
+static int __init sunplus_uart_console_setup(struct console *co, char *options)
+{
+	struct sunplus_uart_port *sup;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	if (co->index < 0 || co->index >= SUP_UART_NR)
+		return -EINVAL;
+
+	sup = sunplus_console_ports[co->index];
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sup->port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver sunplus_uart_driver;
+static struct console sunplus_uart_console = {
+	.name		= "ttySUP",
+	.write		= sunplus_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= sunplus_uart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &sunplus_uart_driver
+};
+#endif
+
+static struct uart_driver sunplus_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "sunplus_uart",
+	.dev_name	= "ttySUP",
+	.major		= TTY_MAJOR,
+	.minor		= 64,
+	.nr		= SUP_UART_NR,
+	.cons		= NULL,
+};
+
+static int sunplus_uart_probe(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup;
+	struct resource *res;
+	struct uart_port *port;
+	int ret, irq;
+
+	pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (pdev->id < 0)
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+
+	if (pdev->id < 0 || pdev->id >= SUP_UART_NR)
+		return -EINVAL;
+
+	sup = devm_kzalloc(&pdev->dev, sizeof(*sup), GFP_KERNEL);
+	if (!sup)
+		return -ENOMEM;
+
+	sup->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(sup->clk)) {
+		ret = clk_prepare_enable(sup->clk);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       (void(*)(void *))clk_disable_unprepare,
+					       sup->clk);
+		if (ret)
+			return ret;
+	} else {
+		if (PTR_ERR(sup->clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		return dev_err_probe(&pdev->dev, PTR_ERR(sup->clk), "clk not found\n");
+	}
+
+	sup->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(sup->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sup->rstc), "rstc not found\n");
+
+	port = &sup->port;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->membase))
+		return dev_err_probe(&pdev->dev, PTR_ERR(port->membase), "membase not found\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	port->mapbase = res->start;
+	port->uartclk = clk_get_rate(sup->clk);
+	port->line = pdev->id;
+	port->irq = irq;
+	port->dev = &pdev->dev;
+	port->iotype = UPIO_MEM;
+	port->ops = &sunplus_uart_ops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->fifosize = 128;
+
+	ret = reset_control_deassert(sup->rstc);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+	if (pdev->id == 0)
+		port->cons = &sunplus_uart_console;
+	sunplus_console_ports[sup->port.line] = sup;
+#endif
+
+	platform_set_drvdata(pdev, &sup->port);
+
+	ret = uart_add_one_port(&sunplus_uart_driver, &sup->port);
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+	if (ret)
+		sunplus_console_ports[sup->port.line] = NULL;
+#endif
+
+#ifdef CONFIG_PM
+	if (!uart_console(&sup->port)) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+#endif
+	return ret;
+}
+
+static int sunplus_uart_remove(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup = platform_get_drvdata(pdev);
+#ifdef CONFIG_PM
+	if (!uart_console(&sup->port)) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
+#endif
+	uart_remove_one_port(&sunplus_uart_driver, &sup->port);
+
+	if (pdev->id < SUP_UART_NR) {
+		clk_disable_unprepare(sup->clk);
+		reset_control_assert(sup->rstc);
+	}
+	return 0;
+}
+
+static int sunplus_uart_suspend(struct device *dev)
+{
+	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
+
+	if (!uart_console(&sup->port))
+		uart_suspend_port(&sunplus_uart_driver, &sup->port);
+
+	return 0;
+}
+
+static int sunplus_uart_resume(struct device *dev)
+{
+	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
+
+	if (!uart_console(&sup->port))
+		uart_resume_port(&sunplus_uart_driver, &sup->port);
+
+	return 0;
+}
+
+static int __maybe_unused sunplus_runtime_suspend(struct device *dev)
+{
+	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
+
+	if (!uart_console(&sup->port))
+		clk_disable_unprepare(sup->clk);
+
+	return 0;
+}
+
+static int __maybe_unused sunplus_runtime_resume(struct device *dev)
+{
+	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
+
+	if (!uart_console(&sup->port))
+		clk_prepare_enable(sup->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sunplus_uart_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sunplus_uart_suspend, sunplus_uart_resume)
+	SET_RUNTIME_PM_OPS(sunplus_runtime_suspend, sunplus_runtime_resume, NULL)
+};
+
+static const struct of_device_id sp_uart_of_match[] = {
+	{ .compatible = "sunplus,sp7021-uart" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sp_uart_of_match);
+
+static struct platform_driver sunplus_uart_platform_driver = {
+	.probe		= sunplus_uart_probe,
+	.remove		= sunplus_uart_remove,
+	.driver = {
+		.name	= "sunplus_uart",
+		.of_match_table = of_match_ptr(sp_uart_of_match),
+		.pm     = &sunplus_uart_pm_ops,
+	}
+};
+
+static int __init sunplus_uart_init(void)
+{
+	int ret;
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+	sunplus_uart_driver.cons = &sunplus_uart_console;
+#endif
+
+	ret = uart_register_driver(&sunplus_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&sunplus_uart_platform_driver);
+	if (ret)
+		uart_unregister_driver(&sunplus_uart_driver);
+
+	return ret;
+}
+
+static void __exit sunplus_uart_exit(void)
+{
+	platform_driver_unregister(&sunplus_uart_platform_driver);
+	uart_unregister_driver(&sunplus_uart_driver);
+}
+
+module_init(sunplus_uart_init);
+module_exit(sunplus_uart_exit);
+
+#ifdef CONFIG_SERIAL_EARLYCON
+static void sunplus_uart_putc(struct uart_port *port, int c)
+{
+	unsigned int val;
+
+	readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
+				  (val & SUP_UART_LSR_TXE), 1, 10000);
+
+	writel(c, port->membase + SUP_UART_DATA);
+}
+
+static void sunplus_uart_early_write(struct console *con, const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, sunplus_uart_putc);
+}
+
+static int __init
+sunplus_uart_early_setup(struct earlycon_device *dev, const char *opt)
+{
+	if (!(dev->port.membase || dev->port.iobase))
+		return -ENODEV;
+
+	dev->con->write = sunplus_uart_early_write;
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(sunplus_uart, "sunplus,sp7021-uart", sunplus_uart_early_setup);
+#endif
+
+MODULE_DESCRIPTION("Sunplus UART driver");
+MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

