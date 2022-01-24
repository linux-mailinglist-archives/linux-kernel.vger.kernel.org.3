Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F181D497945
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiAXHOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbiAXHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B979D21901;
        Mon, 24 Jan 2022 07:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XInksKZ/PHCh49uOtBkdX3ihu5qQlXEfU7MuiKltpQw=;
        b=x2PjdFExGg+xf+Xui7pCUr2WAc1pctqH4AeFEMSUBVs98yUGiV/XYW1m99nXwlq3B4eVWP
        zHWdb7n600eUZ3QAEJDCPfIhYCN82nTY5elTklYC/XHeBDzDySwXELzqrRJYmsq6/hMpr4
        BayIVwP/x8VM+Xeqa/qpzF49GemZkEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XInksKZ/PHCh49uOtBkdX3ihu5qQlXEfU7MuiKltpQw=;
        b=r4cewObGZTQW0Bu35bjO7JNIc22E7xc7812JRUY8fpMEa8+m5y8LWXuh0I1JLj+TBokg+3
        Am+H82bVyYmbBHDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 069D7A3B84;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 10/11] serial: make uart_console_write->putchar()'s character a char
Date:   Mon, 24 Jan 2022 08:14:29 +0100
Message-Id: <20220124071430.14907-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, uart_console_write->putchar's second parameter (the
character) is of type int. It makes little sense, provided uart_console_write()
accepts the input string as "const char *s" and passes its content -- the
characters -- to putchar(). So switch the character's type also to char.

This makes the types consistent.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
Cc: Takao Orito <orito.takao@socionext.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/goldfish.c                     | 2 +-
 drivers/tty/hvc/hvc_dcc.c                  | 2 +-
 drivers/tty/serial/21285.c                 | 2 +-
 drivers/tty/serial/8250/8250_early.c       | 2 +-
 drivers/tty/serial/8250/8250_ingenic.c     | 2 +-
 drivers/tty/serial/8250/8250_port.c        | 2 +-
 drivers/tty/serial/altera_jtaguart.c       | 4 ++--
 drivers/tty/serial/altera_uart.c           | 2 +-
 drivers/tty/serial/amba-pl010.c            | 2 +-
 drivers/tty/serial/amba-pl011.c            | 6 +++---
 drivers/tty/serial/apbuart.c               | 2 +-
 drivers/tty/serial/ar933x_uart.c           | 2 +-
 drivers/tty/serial/arc_uart.c              | 2 +-
 drivers/tty/serial/atmel_serial.c          | 2 +-
 drivers/tty/serial/bcm63xx_uart.c          | 2 +-
 drivers/tty/serial/clps711x.c              | 2 +-
 drivers/tty/serial/digicolor-usart.c       | 2 +-
 drivers/tty/serial/dz.c                    | 2 +-
 drivers/tty/serial/earlycon-arm-semihost.c | 2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c    | 2 +-
 drivers/tty/serial/fsl_linflexuart.c       | 4 ++--
 drivers/tty/serial/fsl_lpuart.c            | 4 ++--
 drivers/tty/serial/imx.c                   | 2 +-
 drivers/tty/serial/imx_earlycon.c          | 2 +-
 drivers/tty/serial/ip22zilog.c             | 2 +-
 drivers/tty/serial/lantiq.c                | 2 +-
 drivers/tty/serial/liteuart.c              | 2 +-
 drivers/tty/serial/lpc32xx_hs.c            | 2 +-
 drivers/tty/serial/meson_uart.c            | 2 +-
 drivers/tty/serial/milbeaut_usio.c         | 2 +-
 drivers/tty/serial/mps2-uart.c             | 4 ++--
 drivers/tty/serial/mvebu-uart.c            | 4 ++--
 drivers/tty/serial/mxs-auart.c             | 2 +-
 drivers/tty/serial/omap-serial.c           | 2 +-
 drivers/tty/serial/owl-uart.c              | 2 +-
 drivers/tty/serial/pch_uart.c              | 2 +-
 drivers/tty/serial/pic32_uart.c            | 2 +-
 drivers/tty/serial/pmac_zilog.c            | 2 +-
 drivers/tty/serial/pxa.c                   | 2 +-
 drivers/tty/serial/qcom_geni_serial.c      | 2 +-
 drivers/tty/serial/rda-uart.c              | 2 +-
 drivers/tty/serial/sa1100.c                | 2 +-
 drivers/tty/serial/samsung_tty.c           | 4 ++--
 drivers/tty/serial/sb1250-duart.c          | 2 +-
 drivers/tty/serial/sccnxp.c                | 2 +-
 drivers/tty/serial/serial_core.c           | 2 +-
 drivers/tty/serial/serial_txx9.c           | 2 +-
 drivers/tty/serial/sh-sci.c                | 2 +-
 drivers/tty/serial/sifive.c                | 4 ++--
 drivers/tty/serial/sprd_serial.c           | 2 +-
 drivers/tty/serial/st-asc.c                | 2 +-
 drivers/tty/serial/stm32-usart.c           | 2 +-
 drivers/tty/serial/sunsu.c                 | 2 +-
 drivers/tty/serial/sunzilog.c              | 4 ++--
 drivers/tty/serial/uartlite.c              | 4 ++--
 drivers/tty/serial/vr41xx_siu.c            | 2 +-
 drivers/tty/serial/vt8500_serial.c         | 2 +-
 drivers/tty/serial/xilinx_uartps.c         | 2 +-
 drivers/tty/serial/zs.c                    | 2 +-
 include/linux/serial_core.h                | 2 +-
 60 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 5ed19a9857ad..bf51559c0ad3 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -434,7 +434,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_GOLDFISH_TTY_EARLY_CONSOLE
-static void gf_early_console_putchar(struct uart_port *port, int ch)
+static void gf_early_console_putchar(struct uart_port *port, char ch)
 {
 	__raw_writel(ch, port->membase);
 }
diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 8e0edb7d93fd..5fa5e3144011 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -15,7 +15,7 @@
 #define DCC_STATUS_RX		(1 << 30)
 #define DCC_STATUS_TX		(1 << 29)
 
-static void dcc_uart_console_putchar(struct uart_port *port, int ch)
+static void dcc_uart_console_putchar(struct uart_port *port, char ch)
 {
 	while (__dcc_getstatus() & DCC_STATUS_TX)
 		cpu_relax();
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 09baef4ccc39..2d32b151191f 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -403,7 +403,7 @@ static void serial21285_setup_ports(void)
 }
 
 #ifdef CONFIG_SERIAL_21285_CONSOLE
-static void serial21285_console_putchar(struct uart_port *port, int ch)
+static void serial21285_console_putchar(struct uart_port *port, char ch)
 {
 	while (*CSR_UARTFLG & 0x20)
 		barrier();
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c171ce6db691..4dedab072922 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -86,7 +86,7 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void serial_putc(struct uart_port *port, int c)
+static void serial_putc(struct uart_port *port, char c)
 {
 	unsigned int status;
 
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 65402d05eff9..269c544113d3 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -52,7 +52,7 @@ static void early_out(struct uart_port *port, int offset, uint8_t value)
 	writel(value, port->membase + (offset << 2));
 }
 
-static void ingenic_early_console_putc(struct uart_port *port, int c)
+static void ingenic_early_console_putc(struct uart_port *port, char c)
 {
 	uint8_t lsr;
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2abb3de11a48..5becb36f40fc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3303,7 +3303,7 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-static void serial8250_console_putchar(struct uart_port *port, int ch)
+static void serial8250_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 37bffe406b18..9b22ce8b69f5 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -298,7 +298,7 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE)
 
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
-static void altera_jtaguart_console_putc(struct uart_port *port, int c)
+static void altera_jtaguart_console_putc(struct uart_port *port, char c)
 {
 	unsigned long status;
 	unsigned long flags;
@@ -318,7 +318,7 @@ static void altera_jtaguart_console_putc(struct uart_port *port, int c)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 #else
-static void altera_jtaguart_console_putc(struct uart_port *port, int c)
+static void altera_jtaguart_console_putc(struct uart_port *port, char c)
 {
 	unsigned long flags;
 
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 64a352b40197..243c30a7c700 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -438,7 +438,7 @@ static struct altera_uart altera_uart_ports[CONFIG_SERIAL_ALTERA_UART_MAXPORTS];
 
 #if defined(CONFIG_SERIAL_ALTERA_UART_CONSOLE)
 
-static void altera_uart_console_putc(struct uart_port *port, int c)
+static void altera_uart_console_putc(struct uart_port *port, char c)
 {
 	while (!(altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
 		 ALTERA_UART_STATUS_TRDY_MSK))
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 47654073123d..5f6e50348cdd 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -556,7 +556,7 @@ static struct uart_amba_port *amba_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_AMBA_PL010_CONSOLE
 
-static void pl010_console_putchar(struct uart_port *port, int ch)
+static void pl010_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1f1df46242f9..ff94edbcd791 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2264,7 +2264,7 @@ static struct uart_amba_port *amba_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_AMBA_PL011_CONSOLE
 
-static void pl011_console_putchar(struct uart_port *port, int ch)
+static void pl011_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
@@ -2480,7 +2480,7 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
-static void qdf2400_e44_putc(struct uart_port *port, int c)
+static void qdf2400_e44_putc(struct uart_port *port, char c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
@@ -2496,7 +2496,7 @@ static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned
 	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
 }
 
-static void pl011_putc(struct uart_port *port, int c)
+static void pl011_putc(struct uart_port *port, char c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d8c937bdf3f9..1dd08c1a7685 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -413,7 +413,7 @@ static void apbuart_flush_fifo(struct uart_port *port)
 
 #ifdef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
 
-static void apbuart_console_putchar(struct uart_port *port, int ch)
+static void apbuart_console_putchar(struct uart_port *port, char ch)
 {
 	unsigned int status;
 	do {
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 8cabe50c4a33..92dea51ff2ec 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -613,7 +613,7 @@ static void ar933x_uart_wait_xmitr(struct ar933x_uart_port *up)
 	} while ((status & AR933X_UART_DATA_TX_CSR) == 0);
 }
 
-static void ar933x_uart_console_putchar(struct uart_port *port, int ch)
+static void ar933x_uart_console_putchar(struct uart_port *port, char ch)
 {
 	struct ar933x_uart_port *up =
 		container_of(port, struct ar933x_uart_port, port);
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 596217d10d5c..e07950ed00b0 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -508,7 +508,7 @@ static int arc_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static void arc_serial_console_putchar(struct uart_port *port, int ch)
+static void arc_serial_console_putchar(struct uart_port *port, char ch)
 {
 	while (!(UART_GET_STATUS(port) & TXEMPTY))
 		cpu_relax();
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2d09a89974a2..e86513227894 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2541,7 +2541,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 }
 
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
-static void atmel_console_putchar(struct uart_port *port, int ch)
+static void atmel_console_putchar(struct uart_port *port, char ch)
 {
 	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
 		cpu_relax();
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 6471a54b616b..50943281b599 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -681,7 +681,7 @@ static void wait_for_xmitr(struct uart_port *port)
 /*
  * output given char
  */
-static void bcm_console_putchar(struct uart_port *port, int ch)
+static void bcm_console_putchar(struct uart_port *port, char ch)
 {
 	wait_for_xmitr(port);
 	bcm_uart_writel(port, ch, UART_FIFO_REG);
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 95abc6faa3d5..36bc82ef7951 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -348,7 +348,7 @@ static const struct uart_ops uart_clps711x_ops = {
 };
 
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
-static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
+static void uart_clps711x_console_putchar(struct uart_port *port, char ch)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	u32 sysflg = 0;
diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 13ac36e2da4f..0641b1c6d1c3 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -381,7 +381,7 @@ static const struct uart_ops digicolor_uart_ops = {
 	.request_port	= digicolor_uart_request_port,
 };
 
-static void digicolor_uart_console_putchar(struct uart_port *port, int ch)
+static void digicolor_uart_console_putchar(struct uart_port *port, char ch)
 {
 	while (digicolor_uart_tx_full(port))
 		cpu_relax();
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index e9edabc5a211..3493e201d67f 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -802,7 +802,7 @@ static void __init dz_init_ports(void)
  * restored.  Welcome to the world of PDP-11!
  * -------------------------------------------------------------------
  */
-static void dz_console_putchar(struct uart_port *uport, int ch)
+static void dz_console_putchar(struct uart_port *uport, char ch)
 {
 	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-arm-semihost.c
index fa096c10b591..01d63aace0d9 100644
--- a/drivers/tty/serial/earlycon-arm-semihost.c
+++ b/drivers/tty/serial/earlycon-arm-semihost.c
@@ -21,7 +21,7 @@
 /*
  * Semihosting-based debug console
  */
-static void smh_putc(struct uart_port *port, int c)
+static void smh_putc(struct uart_port *port, char c)
 {
 #ifdef CONFIG_ARM64
 	asm volatile("mov  x1, %0\n"
diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index ce81523c3113..95dbd1a9a48e 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -10,7 +10,7 @@
 #include <linux/serial_core.h>
 #include <asm/sbi.h>
 
-static void sbi_putc(struct uart_port *port, int c)
+static void sbi_putc(struct uart_port *port, char c)
 {
 	sbi_console_putchar(c);
 }
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e72cba085743..cac2b33d2a66 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -553,7 +553,7 @@ static const struct uart_ops linflex_pops = {
 static struct uart_port *linflex_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE
-static void linflex_console_putchar(struct uart_port *port, int ch)
+static void linflex_console_putchar(struct uart_port *port, char ch)
 {
 	unsigned long cr;
 
@@ -578,7 +578,7 @@ static void linflex_console_putchar(struct uart_port *port, int ch)
 	}
 }
 
-static void linflex_earlycon_putchar(struct uart_port *port, int ch)
+static void linflex_earlycon_putchar(struct uart_port *port, char ch)
 {
 	unsigned long flags;
 	char *ret;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ce3e26144689..b65f9bea67d4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2327,13 +2327,13 @@ static const struct uart_ops lpuart32_pops = {
 static struct lpuart_port *lpuart_ports[UART_NR];
 
 #ifdef CONFIG_SERIAL_FSL_LPUART_CONSOLE
-static void lpuart_console_putchar(struct uart_port *port, int ch)
+static void lpuart_console_putchar(struct uart_port *port, char ch)
 {
 	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TDRE);
 	writeb(ch, port->membase + UARTDR);
 }
 
-static void lpuart32_console_putchar(struct uart_port *port, int ch)
+static void lpuart32_console_putchar(struct uart_port *port, char ch)
 {
 	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
 	lpuart32_write(port, ch, UARTDATA);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index df8a0c8b8b29..8a5e99c54e5c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1958,7 +1958,7 @@ static const struct uart_ops imx_uart_pops = {
 static struct imx_port *imx_uart_ports[UART_NR];
 
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
-static void imx_uart_console_putchar(struct uart_port *port, int ch)
+static void imx_uart_console_putchar(struct uart_port *port, char ch)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 
diff --git a/drivers/tty/serial/imx_earlycon.c b/drivers/tty/serial/imx_earlycon.c
index 795606e1a22f..0da84092a063 100644
--- a/drivers/tty/serial/imx_earlycon.c
+++ b/drivers/tty/serial/imx_earlycon.c
@@ -16,7 +16,7 @@
 #define UTS_TXFULL (1<<4) /* TxFIFO full */
 #define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
 
-static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
+static void imx_uart_console_early_putchar(struct uart_port *port, char ch)
 {
 	while (readl_relaxed(port->membase + IMX21_UTS) & UTS_TXFULL)
 		cpu_relax();
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index f4dc5fe4ba92..be133ba61774 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -990,7 +990,7 @@ static struct zilog_layout * __init get_zs(int chip)
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
 #ifdef CONFIG_SERIAL_IP22_ZILOG_CONSOLE
-static void ip22zilog_put_char(struct uart_port *port, int ch)
+static void ip22zilog_put_char(struct uart_port *port, char ch)
 {
 	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 3e324d3f0a6d..a33b73c49813 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -598,7 +598,7 @@ static const struct uart_ops lqasc_pops = {
 
 #ifdef CONFIG_SERIAL_LANTIQ_CONSOLE
 static void
-lqasc_console_putchar(struct uart_port *port, int ch)
+lqasc_console_putchar(struct uart_port *port, char ch)
 {
 	int fifofree;
 
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 7f74bf7bdcff..76ae24199c7f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -93,7 +93,7 @@ static void liteuart_timer(struct timer_list *t)
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-static void liteuart_putchar(struct uart_port *port, int ch)
+static void liteuart_putchar(struct uart_port *port, char ch)
 {
 	while (litex_read8(port->membase + OFF_TXFULL))
 		cpu_relax();
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 07c4161eb4cc..1d09e27f727b 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -122,7 +122,7 @@ static void wait_for_xmit_ready(struct uart_port *port)
 	}
 }
 
-static void lpc32xx_hsuart_console_putchar(struct uart_port *port, int ch)
+static void lpc32xx_hsuart_console_putchar(struct uart_port *port, char ch)
 {
 	wait_for_xmit_ready(port);
 	writel((u32)ch, LPC32XX_HSUART_FIFO(port->membase));
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 45e00d928253..ca0aab7bf1d0 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -513,7 +513,7 @@ static void meson_uart_enable_tx_engine(struct uart_port *port)
 	writel(val, port->membase + AML_UART_CONTROL);
 }
 
-static void meson_console_putchar(struct uart_port *port, int ch)
+static void meson_console_putchar(struct uart_port *port, char ch)
 {
 	if (!port->membase)
 		return;
diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 8f2cab7f66ad..60f6529a001a 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -400,7 +400,7 @@ static const struct uart_ops mlb_usio_ops = {
 
 #ifdef CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE
 
-static void mlb_usio_console_putchar(struct uart_port *port, int c)
+static void mlb_usio_console_putchar(struct uart_port *port, char c)
 {
 	while (!(readb(port->membase + MLB_USIO_REG_SSR) & MLB_USIO_SSR_TDRE))
 		cpu_relax();
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..8af28a73fb25 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -432,7 +432,7 @@ static const struct uart_ops mps2_uart_pops = {
 static DEFINE_IDR(ports_idr);
 
 #ifdef CONFIG_SERIAL_MPS2_UART_CONSOLE
-static void mps2_uart_console_putchar(struct uart_port *port, int ch)
+static void mps2_uart_console_putchar(struct uart_port *port, char ch)
 {
 	while (mps2_uart_read8(port, UARTn_STATE) & UARTn_STATE_TX_FULL)
 		cpu_relax();
@@ -484,7 +484,7 @@ static struct console mps2_uart_console = {
 
 #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
 
-static void mps2_early_putchar(struct uart_port *port, int ch)
+static void mps2_early_putchar(struct uart_port *port, char ch)
 {
 	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
 		cpu_relax();
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ab226da75f7b..924af67f73f5 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -598,7 +598,7 @@ static const struct uart_ops mvebu_uart_ops = {
 
 #ifdef CONFIG_SERIAL_MVEBU_CONSOLE
 /* Early Console */
-static void mvebu_uart_putc(struct uart_port *port, int c)
+static void mvebu_uart_putc(struct uart_port *port, char c)
 {
 	unsigned int st;
 
@@ -659,7 +659,7 @@ static void wait_for_xmite(struct uart_port *port)
 				  (val & STAT_TX_EMP), 1, 10000);
 }
 
-static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
+static void mvebu_uart_console_putchar(struct uart_port *port, char ch)
 {
 	wait_for_xmitr(port);
 	writel(ch, port->membase + UART_TSH(port));
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ac45f3386e97..29ccaa0031c8 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1305,7 +1305,7 @@ static const struct uart_ops mxs_auart_ops = {
 static struct mxs_auart_port *auart_port[MXS_AUART_PORTS];
 
 #ifdef CONFIG_SERIAL_MXS_AUART_CONSOLE
-static void mxs_auart_console_putchar(struct uart_port *port, int ch)
+static void mxs_auart_console_putchar(struct uart_port *port, char ch)
 {
 	struct mxs_auart_port *s = to_auart_port(port);
 	unsigned int to = 1000;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0862941862c8..464e9b2a4064 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1194,7 +1194,7 @@ static void omap_serial_early_out(struct uart_port *port, int offset,
 	writew(value, port->membase + offset);
 }
 
-static void omap_serial_early_putc(struct uart_port *port, int c)
+static void omap_serial_early_putc(struct uart_port *port, char c)
 {
 	unsigned int status;
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..60eea8e471d8 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -516,7 +516,7 @@ static const struct uart_ops owl_uart_ops = {
 
 #ifdef CONFIG_SERIAL_OWL_CONSOLE
 
-static void owl_console_putchar(struct uart_port *port, int ch)
+static void owl_console_putchar(struct uart_port *port, char ch)
 {
 	if (!port->membase)
 		return;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index f0351e6f0ef6..97b76344288e 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1600,7 +1600,7 @@ static const struct uart_ops pch_uart_ops = {
 
 #ifdef CONFIG_SERIAL_PCH_UART_CONSOLE
 
-static void pch_console_putchar(struct uart_port *port, int ch)
+static void pch_console_putchar(struct uart_port *port, char ch)
 {
 	struct eg20t_port *priv =
 		container_of(port, struct eg20t_port, port);
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0a12fb11e698..c5dca0a19dbb 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -691,7 +691,7 @@ static const struct uart_ops pic32_uart_ops = {
 
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
 /* output given char */
-static void pic32_console_putchar(struct uart_port *port, int ch)
+static void pic32_console_putchar(struct uart_port *port, char ch)
 {
 	struct pic32_sport *sport = to_pic32_sport(port);
 
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 5359236b32d6..555f94240098 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1944,7 +1944,7 @@ static void __exit exit_pmz(void)
 
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 
-static void pmz_console_putchar(struct uart_port *port, int ch)
+static void pmz_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_pmac_port *uap =
 		container_of(port, struct uart_pmac_port, port);
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 30b099746a75..c92502abe6fb 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -619,7 +619,7 @@ static void wait_for_xmitr(struct uart_pxa_port *up)
 	}
 }
 
-static void serial_pxa_console_putchar(struct uart_port *port, int ch)
+static void serial_pxa_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index aedc38893e6c..38c2877881a4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -397,7 +397,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 #endif
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
-static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
+static void qcom_geni_serial_wr_char(struct uart_port *uport, char ch)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index d550d8fa2fab..95af78d8140b 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -573,7 +573,7 @@ static const struct uart_ops rda_uart_ops = {
 
 #ifdef CONFIG_SERIAL_RDA_CONSOLE
 
-static void rda_console_putchar(struct uart_port *port, int ch)
+static void rda_console_putchar(struct uart_port *port, char ch)
 {
 	if (!port->membase)
 		return;
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 697b6a002a16..bfd37745cc6e 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -695,7 +695,7 @@ void __init sa1100_register_uart(int idx, int port)
 
 
 #ifdef CONFIG_SERIAL_SA1100_CONSOLE
-static void sa1100_console_putchar(struct uart_port *port, int ch)
+static void sa1100_console_putchar(struct uart_port *port, char ch)
 {
 	struct sa1100_port *sport =
 		container_of(port, struct sa1100_port, port);
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..6fef292d6e9c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2478,7 +2478,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 #endif /* CONFIG_CONSOLE_POLL */
 
 static void
-s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
+s3c24xx_serial_console_putchar(struct uart_port *port, char ch)
 {
 	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
 
@@ -2965,7 +2965,7 @@ static void samsung_early_busyuart_fifo(struct uart_port *port)
 		;
 }
 
-static void samsung_early_putc(struct uart_port *port, int c)
+static void samsung_early_putc(struct uart_port *port, char c)
 {
 	if (readl(port->membase + S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE)
 		samsung_early_busyuart_fifo(port);
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 738df6d9c0d9..bb1913050796 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -820,7 +820,7 @@ static void __init sbd_probe_duarts(void)
  * console output.  The console_lock is held by the caller, so we
  * shouldn't be interrupted for more console activity.
  */
-static void sbd_console_putchar(struct uart_port *uport, int ch)
+static void sbd_console_putchar(struct uart_port *uport, char ch)
 {
 	struct sbd_port *sport = to_sport(uport);
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 10cc16a71f26..3ee2c942ac22 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -828,7 +828,7 @@ static const struct uart_ops sccnxp_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SCCNXP_CONSOLE
-static void sccnxp_console_putchar(struct uart_port *port, int c)
+static void sccnxp_console_putchar(struct uart_port *port, char c)
 {
 	int tryes = 100000;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1f6df577c75b..33742d86a12e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1926,7 +1926,7 @@ static void uart_port_spin_lock_init(struct uart_port *port)
  */
 void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
-			void (*putchar)(struct uart_port *, int))
+			void (*putchar)(struct uart_port *, char))
 {
 	unsigned int i;
 
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index aaca4fe38486..e1003fd280dd 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -879,7 +879,7 @@ static void __init serial_txx9_register_ports(struct uart_driver *drv,
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 
-static void serial_txx9_console_putchar(struct uart_port *port, int ch)
+static void serial_txx9_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_txx9_port *up = to_uart_txx9_port(port);
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b610b27893a8..67846605713b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2957,7 +2957,7 @@ static void sci_cleanup_single(struct sci_port *port)
 
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
-static void serial_console_putchar(struct uart_port *port, int ch)
+static void serial_console_putchar(struct uart_port *port, char ch)
 {
 	sci_poll_put_char(port, ch);
 }
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index b79900d0e91a..9f4923bc3afb 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -756,7 +756,7 @@ static void sifive_serial_poll_put_char(struct uart_port *port,
  */
 
 #ifdef CONFIG_SERIAL_EARLYCON
-static void early_sifive_serial_putc(struct uart_port *port, int c)
+static void early_sifive_serial_putc(struct uart_port *port, char c)
 {
 	while (__ssp_early_readl(port, SIFIVE_SERIAL_TXDATA_OFFS) &
 	       SIFIVE_SERIAL_TXDATA_FULL_MASK)
@@ -800,7 +800,7 @@ OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
 
 static struct sifive_serial_port *sifive_serial_console_ports[SIFIVE_SERIAL_MAX_PORTS];
 
-static void sifive_serial_console_putchar(struct uart_port *port, int ch)
+static void sifive_serial_console_putchar(struct uart_port *port, char ch)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
 
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9a7ae6384edf..45cebfed0378 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1058,7 +1058,7 @@ console_initcall(sprd_serial_console_init);
 #define SPRD_CONSOLE	(&sprd_console)
 
 /* Support for earlycon */
-static void sprd_putc(struct uart_port *port, int c)
+static void sprd_putc(struct uart_port *port, char c)
 {
 	unsigned int timeout = SPRD_TIMEOUT;
 
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 87e480cc8206..6418a7f4fdde 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -854,7 +854,7 @@ static int asc_serial_resume(struct device *dev)
 /*----------------------------------------------------------------------*/
 
 #ifdef CONFIG_SERIAL_ST_ASC_CONSOLE
-static void asc_console_putchar(struct uart_port *port, int ch)
+static void asc_console_putchar(struct uart_port *port, char ch)
 {
 	unsigned int timeout = 1000000;
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1f89ab0e49ac..7c7aace2418f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1629,7 +1629,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_SERIAL_STM32_CONSOLE
-static void stm32_usart_console_putchar(struct uart_port *port, int ch)
+static void stm32_usart_console_putchar(struct uart_port *port, char ch)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 98b2f4fb9a99..029a98ead88c 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1281,7 +1281,7 @@ static void wait_for_xmitr(struct uart_sunsu_port *up)
 	}
 }
 
-static void sunsu_console_putchar(struct uart_port *port, int ch)
+static void sunsu_console_putchar(struct uart_port *port, char ch)
 {
 	struct uart_sunsu_port *up =
 		container_of(port, struct uart_sunsu_port, port);
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index b714b00d2dad..d070e42f1c37 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -100,7 +100,7 @@ struct uart_sunzilog_port {
 #endif
 };
 
-static void sunzilog_putchar(struct uart_port *port, int ch);
+static void sunzilog_putchar(struct uart_port *port, char ch);
 
 #define ZILOG_CHANNEL_FROM_PORT(PORT)	((struct zilog_channel __iomem *)((PORT)->membase))
 #define UART_ZILOG(PORT)		((struct uart_sunzilog_port *)(PORT))
@@ -1125,7 +1125,7 @@ static void sunzilog_free_tables(void)
 
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
-static void __maybe_unused sunzilog_putchar(struct uart_port *port, int ch)
+static void __maybe_unused sunzilog_putchar(struct uart_port *port, char ch)
 {
 	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index e1fa52d31474..f1b342c1e2fb 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -482,7 +482,7 @@ static void ulite_console_wait_tx(struct uart_port *port)
 			 "timeout waiting for TX buffer empty\n");
 }
 
-static void ulite_console_putchar(struct uart_port *port, int ch)
+static void ulite_console_putchar(struct uart_port *port, char ch)
 {
 	ulite_console_wait_tx(port);
 	uart_out32(ch, ULITE_TX, port);
@@ -558,7 +558,7 @@ static struct console ulite_console = {
 	.data	= &ulite_uart_driver,
 };
 
-static void early_uartlite_putc(struct uart_port *port, int c)
+static void early_uartlite_putc(struct uart_port *port, char c)
 {
 	/*
 	 * Limit how many times we'll spin waiting for TX FIFO status.
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 647198b1e2b9..8029d2d8e6fb 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -743,7 +743,7 @@ static void wait_for_xmitr(struct uart_port *port)
 	}
 }
 
-static void siu_console_putchar(struct uart_port *port, int ch)
+static void siu_console_putchar(struct uart_port *port, char ch)
 {
 	wait_for_xmitr(port);
 	siu_write(port, UART_TX, ch);
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 9adfe3dc970f..375a6959439d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -484,7 +484,7 @@ static void wait_for_xmitr(struct uart_port *port)
 	} while (status & 0x10);
 }
 
-static void vt8500_console_putchar(struct uart_port *port, int c)
+static void vt8500_console_putchar(struct uart_port *port, char c)
 {
 	wait_for_xmitr(port);
 	writeb(c, port->membase + VT8500_TXFIFO);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d5e243908d9f..bdcd7dd743ef 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1142,7 +1142,7 @@ static struct uart_driver cdns_uart_uart_driver;
  * @port: Handle to the uart port structure
  * @ch: Character to be written
  */
-static void cdns_uart_console_putchar(struct uart_port *port, int ch)
+static void cdns_uart_console_putchar(struct uart_port *port, char ch)
 {
 	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
 		cpu_relax();
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 4b4f604646a7..d63aa07653ca 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -1124,7 +1124,7 @@ static int __init zs_probe_sccs(void)
 
 
 #ifdef CONFIG_SERIAL_ZS_CONSOLE
-static void zs_console_putchar(struct uart_port *uport, int ch)
+static void zs_console_putchar(struct uart_port *uport, char ch)
 {
 	struct zs_port *zport = to_zport(uport);
 	struct zs_scc *scc = zport->scc;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c58cc142d23f..68e62703eaa6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -399,7 +399,7 @@ int uart_set_options(struct uart_port *port, struct console *co, int baud,
 struct tty_driver *uart_console_device(struct console *co, int *index);
 void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
-			void (*putchar)(struct uart_port *, int));
+			void (*putchar)(struct uart_port *, char));
 
 /*
  * Port/driver registration/removal
-- 
2.34.1

