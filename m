Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1A472164
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhLMHKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhLMHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:10:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92BDC06173F;
        Sun, 12 Dec 2021 23:10:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v19so10519153plo.7;
        Sun, 12 Dec 2021 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gSsxO+VQnR8vI25qIoqVDmlvsGxKhH/IXg61YJoF2mY=;
        b=H/3VVFeS1xQUB4Du4cSdDrfNbCkALhovyoHdqi0sZpXuiU/jPDStSF+THt0jFRJiQ0
         Z3eon9oKMI/Rq4OLi1Gqzf2wJWILH4HUcaeiAYiWJdM79dXZ0CpEm20D2t8tu8Baa/Dr
         ZFPf83EptMiU310VI+uTcLltvDmgR2Dw/+2S+0Fcb/l7vSbumJi30XdBJ/9eSXBD9zuL
         zNfQrjDLV1/0l6phsreenFv9a048d4yMjoPeEDAg6ZHSMUcqQ4vBPwmrhgDTFT/Qd+Xs
         1AuNiEEkrv/n16nvrf5LJcH9TwmZgx38kqfb4SHxbJ4IO3ptsM5Ojxypie7S3K+vpIyQ
         ce6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gSsxO+VQnR8vI25qIoqVDmlvsGxKhH/IXg61YJoF2mY=;
        b=gYhZLPDNohSVL4K7LjLKvxtwunl8hKKSZnQdzouzpxOWiMWASzpXGcfVB6w83gc0zb
         f54AQzmGVLaaS8MJd40Ms9tptic52UdccaKP7CwugCjQRoWxbDgvhQxwNeE7Aa+u2AwP
         t6WiWpMBnEFoj/oS7jiUPan1QiF6g5FsAmahcHDpfQ0ORq8hLjsi3F0r6z9ctUQ0UKwu
         oq6VVDvsFfBgsnX2/gkjNdnovaECpDwIc+a33j+w/MqLTuSb+RIffx6ssU6x/tWdtjIM
         uPFMy4ot7Agv078S0tTVgrLFVaKQSFHUhx2EuL8e6wK/ZLA6y1CnOuY1RpXc2zURAXs3
         Dg1g==
X-Gm-Message-State: AOAM532jXK+NfH7r7NEWZtevElv0SAKSuWXRAAo1Lk4aU6aUBoCeTj8j
        HWW6y11bgWqv2rrGj+cwqzQ=
X-Google-Smtp-Source: ABdhPJw4qP/2kneyouUe+J/GVXPKituDSE+lnuwzqz/7eZbseWLZTl6HvvaVi3HVAOtLWEr0AhMmBA==
X-Received: by 2002:a17:903:1208:b0:143:e4e9:4ce3 with SMTP id l8-20020a170903120800b00143e4e94ce3mr93147476plh.21.1639379410341;
        Sun, 12 Dec 2021 23:10:10 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x16sm10601848pfo.165.2021.12.12.23.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:10:10 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Date:   Mon, 13 Dec 2021 15:10:07 +0800
Message-Id: <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v5:
 - Addressed all comments from Andy Shevchenko.

 MAINTAINERS                       |   1 +
 drivers/tty/serial/Kconfig        |  25 ++
 drivers/tty/serial/Makefile       |   1 +
 drivers/tty/serial/sunplus-uart.c | 782 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h  |   3 +
 5 files changed, 812 insertions(+)
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
index 131a6a5..0865da3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1561,6 +1561,31 @@ config SERIAL_LITEUART_CONSOLE
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
+	  This driver can also be built as a module. If so, the module will be
+	  called sunplus-uart.
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
index 0000000..a8146db
--- /dev/null
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -0,0 +1,782 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sunplus SoC UART driver
+ *
+ * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
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
+#define SUP_UART_NR			5
+
+struct sunplus_uart_port {
+	struct uart_port port;
+	struct clk *clk;
+	struct reset_control *rstc;
+};
+
+static void sp_uart_put_char(struct uart_port *port, unsigned int ch)
+{
+	writel(ch, port->membase + SUP_UART_DATA);
+}
+
+static u32 sunplus_tx_buf_not_full(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+
+	return (lsr & SUP_UART_LSR_TX) ? SUP_UART_LSR_TX_NOT_FULL : 0;
+}
+
+static unsigned int sunplus_tx_empty(struct uart_port *port)
+{
+	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
+
+	return (lsr & SUP_UART_LSR_TXE) ? TIOCSER_TEMT : 0;
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
+		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;
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
+	unsigned int isc = readl(port->membase + SUP_UART_ISC);
+
+	spin_lock(&port->lock);
+
+	if (isc & SUP_UART_ISC_RX)
+		receive_chars(port);
+
+	if (isc & SUP_UART_ISC_TX)
+		transmit_chars(port);
+
+	spin_unlock(&port->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int sunplus_startup(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int isc;
+	int ret;
+
+	ret = request_irq(port->irq, sunplus_uart_irq, 0, "sunplus_uart", port);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	isc |= SUP_UART_ISC_RXM;
+	writel(isc, port->membase + SUP_UART_ISC);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
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
+	u32 ext, div, div_l, div_h, baud, lcr;
+	u32 clk = port->uartclk;
+	unsigned long flags;
+
+	baud = uart_get_baud_rate(port, termios, oldtermios, 0, port->uartclk / 16);
+
+	/* baud rate = uartclk / ((16 * divisor + 1) + divisor_ext) */
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
+	return port->type == PORT_SUNPLUS ? "sunplus_uart" : NULL;
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
+static int sunplus_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_SUNPLUS)
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
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
+	.tx_empty	= sunplus_tx_empty,
+	.set_mctrl	= sunplus_set_mctrl,
+	.get_mctrl	= sunplus_get_mctrl,
+	.stop_tx	= sunplus_stop_tx,
+	.start_tx	= sunplus_start_tx,
+	.stop_rx	= sunplus_stop_rx,
+	.break_ctl	= sunplus_break_ctl,
+	.startup	= sunplus_startup,
+	.shutdown	= sunplus_shutdown,
+	.set_termios	= sunplus_set_termios,
+	.set_ldisc	= sunplus_set_ldisc,
+	.type		= sunplus_type,
+	.release_port	= sunplus_release_port,
+	.request_port	= sunplus_request_port,
+	.config_port	= sunplus_config_port,
+	.verify_port	= sunplus_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_put_char	= sunplus_poll_put_char,
+	.poll_get_char	= sunplus_poll_get_char,
+#endif
+};
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
+
+static void wait_for_xmitr(struct uart_port *port)
+{
+	unsigned int val;
+	int ret;
+
+	/* Wait while FIFO is full or timeout */
+	ret = readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
+					(val & SUP_UART_LSR_TX), 1, 10000);
+
+	if (ret == -ETIMEDOUT) {
+		dev_err(port->dev, "Timeout waiting while UART TX FULL\n");
+		return;
+	}
+}
+
+static void sunplus_uart_console_putchar(struct uart_port *port, int ch)
+{
+	wait_for_xmitr(port);
+	sp_uart_put_char(port, ch);
+}
+
+static void sunplus_console_write(struct console *co,
+				  const char *s,
+				  unsigned int count)
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
+static int __init sunplus_console_setup(struct console *co, char *options)
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
+	if (!sup)
+		return -ENODEV;
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
+	.write		= sunplus_console_write,
+	.device		= uart_console_device,
+	.setup		= sunplus_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &sunplus_uart_driver
+};
+
+static int __init sunplus_console_init(void)
+{
+	register_console(&sunplus_uart_console);
+	return 0;
+}
+console_initcall(sunplus_console_init);
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
+	struct uart_port *port;
+	struct resource *res;
+	int ret, irq;
+
+	pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+	if (pdev->id < 0 || pdev->id >= SUP_UART_NR)
+		return -EINVAL;
+
+	sup = devm_kzalloc(&pdev->dev, sizeof(*sup), GFP_KERNEL);
+	if (!sup)
+		return -ENOMEM;
+
+	sup->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(sup->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sup->clk), "clk not found\n");
+
+	ret = clk_prepare_enable(sup->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       sup->clk);
+	if (ret)
+		return ret;
+
+	sup->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(sup->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sup->rstc), "rstc not found\n");
+
+	port = &sup->port;
+
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
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
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))reset_control_assert,
+				       sup->rstc);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
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
+	return ret;
+}
+
+static int sunplus_uart_remove(struct platform_device *pdev)
+{
+	struct sunplus_uart_port *sup = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&sunplus_uart_driver, &sup->port);
+
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
+static const struct dev_pm_ops sunplus_uart_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sunplus_uart_suspend, sunplus_uart_resume)
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
+		.of_match_table = sp_uart_of_match,
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
+module_init(sunplus_uart_init);
+
+static void __exit sunplus_uart_exit(void)
+{
+	platform_driver_unregister(&sunplus_uart_platform_driver);
+	uart_unregister_driver(&sunplus_uart_driver);
+}
+module_exit(sunplus_uart_exit);
+
+#ifdef CONFIG_SERIAL_EARLYCON
+static void sunplus_uart_putc(struct uart_port *port, int c)
+{
+	unsigned int val;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
+					(val & SUP_UART_LSR_TXE), 1, 10000);
+	if (ret)
+		return;
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
+OF_EARLYCON_DECLARE(sunplus_uart, "sunplus,sp7021-uart", sunplus_uart_early_setup);
+#endif
+
+MODULE_DESCRIPTION("Sunplus UART driver");
+MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index c4042dc..2dfe443 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -274,4 +274,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* Sunplus UART */
+#define PORT_SUNPLUS	123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.7.4

