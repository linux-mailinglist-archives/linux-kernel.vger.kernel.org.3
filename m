Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5655108D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiFTGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiFTGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:41:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667EDF50;
        Sun, 19 Jun 2022 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655707267; x=1687243267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTbrxlLvbONHGrsXQplL9RHDFqZwxPgFVN03BIBT1ys=;
  b=E5NKeQ91A32MhPP5fkeN5H7+M/goVVztl6p6WwqZ4o4h+Ohe84v0afdx
   VhjnjNOi1FcuiZByMKhJ98y1uAZoVYh9niMdCdwQhhGyKxlb469lcImGu
   Z64SEed3Wz+nMhyikQyatwU0lheSCIoCbY6Ozs4CW88hQqdbmRBESEbbl
   dOfmuODA14S0lD9MhebbR7xHgnwZvLrmb0u4IgpiiR25NH++e1hXvX7xA
   OkumQRjOdfZeRkxX/XSJHAiVZYvEPt8CjM+br96ZqMoer1fyauQsWIj2T
   HUzxQRjMLa9JKXmzrYmUzrO2qTPrPh3qq3PoIy3rd2NvQrvUU6iucs68H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260247010"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260247010"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:41:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642967743"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:41:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 4/6] serial: take termios_rwsem for ->rs485_config() & pass termios as param
Date:   Mon, 20 Jun 2022 09:40:28 +0300
Message-Id: <20220620064030.7938-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
References: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
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

To be able to alter ADDRB within ->rs485_config(), take termios_rwsem
before calling ->rs485_config() and pass termios.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h         |  3 ++-
 drivers/tty/serial/8250/8250_dwlib.c   |  3 ++-
 drivers/tty/serial/8250/8250_exar.c    |  9 +++++----
 drivers/tty/serial/8250/8250_fintek.c  |  2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c |  2 +-
 drivers/tty/serial/8250/8250_pci.c     |  2 +-
 drivers/tty/serial/8250/8250_port.c    |  3 ++-
 drivers/tty/serial/amba-pl011.c        |  2 +-
 drivers/tty/serial/ar933x_uart.c       |  2 +-
 drivers/tty/serial/atmel_serial.c      |  2 +-
 drivers/tty/serial/fsl_lpuart.c        |  4 ++--
 drivers/tty/serial/imx.c               |  2 +-
 drivers/tty/serial/max310x.c           |  2 +-
 drivers/tty/serial/mcf.c               |  3 ++-
 drivers/tty/serial/omap-serial.c       |  3 ++-
 drivers/tty/serial/sc16is7xx.c         |  2 +-
 drivers/tty/serial/serial_core.c       | 14 ++++++++++----
 drivers/tty/serial/stm32-usart.c       |  2 +-
 include/linux/serial_core.h            |  1 +
 19 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 5cc967fe3b59..287153d32536 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -203,7 +203,8 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
-int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485);
+int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
+			    struct serial_rs485 *rs485);
 void serial8250_em485_start_tx(struct uart_8250_port *p);
 void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index c83e7eaf3877..d1ff3daeb0ba 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -85,7 +85,8 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
-static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
+static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
+			       struct serial_rs485 *rs485)
 {
 	u32 tcr;
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3d999eec4087..f5344cfe303c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -112,7 +112,8 @@
 struct exar8250;
 
 struct exar8250_platform {
-	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
+			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 	void (*unregister_gpio)(struct uart_8250_port *);
@@ -409,7 +410,7 @@ static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
 	port->port.private_data = NULL;
 }
 
-static int generic_rs485_config(struct uart_port *port,
+static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
@@ -441,7 +442,7 @@ static const struct exar8250_platform exar8250_default_platform = {
 	.rs485_supported = &generic_rs485_supported,
 };
 
-static int iot2040_rs485_config(struct uart_port *port,
+static int iot2040_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
@@ -471,7 +472,7 @@ static int iot2040_rs485_config(struct uart_port *port,
 	value |= mode;
 	writeb(value, p + UART_EXAR_MPIOLVL_7_0);
 
-	return generic_rs485_config(port, rs485);
+	return generic_rs485_config(port, termios, rs485);
 }
 
 static const struct serial_rs485 iot2040_rs485_supported = {
diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 1fb86c73786c..eea693f5b577 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -191,7 +191,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 	return -ENODEV;
 }
 
-static int fintek_8250_rs485_config(struct uart_port *port,
+static int fintek_8250_rs485_config(struct uart_port *port, struct ktermios *termios,
 			      struct serial_rs485 *rs485)
 {
 	uint8_t config = 0;
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 3a1cb51cbc91..d7cb3bb52069 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -32,7 +32,7 @@ struct lpc18xx_uart_data {
 	int line;
 };
 
-static int lpc18xx_rs485_config(struct uart_port *port,
+static int lpc18xx_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b6d71268aa7d..d31d2350a9db 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1553,7 +1553,7 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 #define FINTEK_RTS_INVERT		BIT(5)
 
 /* We should do proper H/W transceiver setting before change to RS485 mode */
-static int pci_fintek_rs485_config(struct uart_port *port,
+static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *termios,
 			       struct serial_rs485 *rs485)
 {
 	struct pci_dev *pci_dev = to_pci_dev(port->dev);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 19c612d732cf..5cb3673f9ee5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -664,7 +664,8 @@ EXPORT_SYMBOL_GPL(serial8250_em485_supported);
  * if the uart is incapable of driving RTS as a Transmit Enable signal in
  * hardware, relying on software emulation instead.
  */
-int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
+int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
+			    struct serial_rs485 *rs485)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index eccd66625d25..c8f52945a4aa 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2197,7 +2197,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
-static int pl011_rs485_config(struct uart_port *port,
+static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 			      struct serial_rs485 *rs485)
 {
 	struct uart_amba_port *uap =
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index ab2c5b2a1ce8..b73ce13683db 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -580,7 +580,7 @@ static const struct uart_ops ar933x_uart_ops = {
 	.verify_port	= ar933x_uart_verify_port,
 };
 
-static int ar933x_config_rs485(struct uart_port *port,
+static int ar933x_config_rs485(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485conf)
 {
 	struct ar933x_uart_port *up =
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 74dd1d3ac46f..64dd6fea0a30 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -285,7 +285,7 @@ static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
 }
 
 /* Enable or disable the rs485 support */
-static int atmel_config_rs485(struct uart_port *port,
+static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
 			      struct serial_rs485 *rs485conf)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index d35414cb3e4e..8fe0494d4057 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1355,7 +1355,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 	sport->dma_rx_cookie = -EINVAL;
 }
 
-static int lpuart_config_rs485(struct uart_port *port,
+static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
 	struct lpuart_port *sport = container_of(port,
@@ -1385,7 +1385,7 @@ static int lpuart_config_rs485(struct uart_port *port,
 	return 0;
 }
 
-static int lpuart32_config_rs485(struct uart_port *port,
+static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
 	struct lpuart_port *sport = container_of(port,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4edde54175f..3457006cea3f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1907,7 +1907,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 #endif
 
 /* called with port.lock taken and irqs off or from .probe without locking */
-static int imx_uart_rs485_config(struct uart_port *port,
+static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termios,
 				 struct serial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d7d1791fcb57..5a8521fb9237 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1026,7 +1026,7 @@ static void max310x_rs_proc(struct work_struct *ws)
 			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
-static int max310x_rs485_config(struct uart_port *port,
+static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	struct max310x_one *one = to_max310x_port(port);
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 036f178e3d66..73c5287b8e5e 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -431,7 +431,8 @@ static int mcf_verify_port(struct uart_port *port, struct serial_struct *ser)
 /****************************************************************************/
 
 /* Enable or disable the RS485 support */
-static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+static int mcf_config_rs485(struct uart_port *port, struct ktermios *termios,
+			    struct serial_rs485 *rs485)
 {
 	unsigned char mr1, mr2;
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 98622c35d896..1d1e48ff33d8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1325,7 +1325,8 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
 /* Enable or disable the rs485 support */
 static int
-serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+serial_omap_config_rs485(struct uart_port *port, struct ktermios *termios,
+			 struct serial_rs485 *rs485)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned int mode;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 2ceecaa4a478..8cb92a3b3fb8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1127,7 +1127,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int sc16is7xx_config_rs485(struct uart_port *port,
+static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termios,
 				  struct serial_rs485 *rs485)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 621fc15e2e54..44c3785445e3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1359,7 +1359,7 @@ int uart_rs485_config(struct uart_port *port)
 
 	uart_sanitize_serial_rs485(port, rs485);
 
-	ret = port->rs485_config(port, rs485);
+	ret = port->rs485_config(port, NULL, rs485);
 	if (ret)
 		memset(rs485, 0, sizeof(*rs485));
 
@@ -1383,7 +1383,7 @@ static int uart_get_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int uart_set_rs485_config(struct uart_port *port,
+static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			 struct serial_rs485 __user *rs485_user)
 {
 	struct serial_rs485 rs485;
@@ -1402,7 +1402,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 	uart_sanitize_serial_rs485(port, &rs485);
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = port->rs485_config(port, &rs485);
+	ret = port->rs485_config(port, &tty->termios, &rs485);
 	if (!ret)
 		port->rs485 = rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1511,6 +1511,10 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	if (ret != -ENOIOCTLCMD)
 		goto out;
 
+	/* rs485_config requires more locking than others */
+	if (cmd == TIOCGRS485)
+		down_write(&tty->termios_rwsem);
+
 	mutex_lock(&port->mutex);
 	uport = uart_port_check(state);
 
@@ -1534,7 +1538,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 		break;
 
 	case TIOCSRS485:
-		ret = uart_set_rs485_config(uport, uarg);
+		ret = uart_set_rs485_config(tty, uport, uarg);
 		break;
 
 	case TIOCSISO7816:
@@ -1551,6 +1555,8 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	}
 out_up:
 	mutex_unlock(&port->mutex);
+	if (cmd == TIOCGRS485)
+		up_write(&tty->termios_rwsem);
 out:
 	return ret;
 }
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index db3dd9731ee1..13992e64a7df 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -97,7 +97,7 @@ static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 	*cr1 |= rs485_deat_dedt;
 }
 
-static int stm32_usart_config_rs485(struct uart_port *port,
+static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *termios,
 				    struct serial_rs485 *rs485conf)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5518b70177b3..17bbd0412a23 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -132,6 +132,7 @@ struct uart_port {
 				      unsigned int old);
 	void			(*handle_break)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
+						struct ktermios *termios,
 						struct serial_rs485 *rs485);
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
-- 
2.30.2

