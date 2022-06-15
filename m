Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CE54C8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiFOMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348983AbiFOMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:49:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A5192A3;
        Wed, 15 Jun 2022 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655297346; x=1686833346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkWNS1JY+Km6270SQ6VP3bBDBqzjTKZzztGuGJrCrAw=;
  b=SLzqqc33+xQh+rh0ZoplUOFZLNh8vLZpbPJmvAyOfjYUfF87Yjs1AiB/
   wDHAoDYavZtsUTT7GagQBUYcBtIQqrUzMsbiD9K00glQq88qd5ndrNM6h
   9YQgvsIi+hsayNXAT6syvAW7C7WedtHExRVnuWDzmz3NAYjj4EiOhNR7c
   iyy2y9TZNzr2ThJ+XoZEbJRi1tSLL7z3nCT+36qE24HygclAxFAdhHv55
   7KmtM8byoKUO539EqUGzJ08KQx/fPSEziQB1Ff3v0+eoynKLJKhkWpo5G
   Be/he/O5kRjOHtjjaretD4WNFx+J9gUaLfMFYZQhc4Cl9jMgfZfFWKqfX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258800963"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258800963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:49:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687288124"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:49:00 -0700
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
Subject: [PATCH v7 4/6] serial: take termios_rwsem for .rs485_config() & pass termios as param
Date:   Wed, 15 Jun 2022 15:48:27 +0300
Message-Id: <20220615124829.34516-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to alter ADDRB within .rs485_config(), take termios_rwsem
before calling .rs485_config() and pass termios.

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
 drivers/tty/serial/serial_core.c       | 15 +++++++++++----
 drivers/tty/serial/stm32-usart.c       |  2 +-
 include/linux/serial_core.h            |  3 ++-
 19 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 5cc967fe3b59..e7ba6500aedf 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -203,7 +203,8 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
-int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485);
+int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485,
+			    struct ktermios *termios);
 void serial8250_em485_start_tx(struct uart_8250_port *p);
 void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index c83e7eaf3877..c9d9bd7f7bd9 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -85,7 +85,8 @@ void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct
 }
 EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
 
-static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
+static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485,
+			       struct ktermios *termios)
 {
 	u32 tcr;
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 8be3c9ecd623..ff67d154a7b5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -112,7 +112,8 @@
 struct exar8250;
 
 struct exar8250_platform {
-	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	int (*rs485_config)(struct uart_port *port, struct serial_rs485 *rs485,
+			    struct ktermios *termios);
 	const struct serial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 	void (*unregister_gpio)(struct uart_8250_port *);
@@ -410,7 +411,7 @@ static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
 }
 
 static int generic_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
+				struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
 	u8 __iomem *p = port->membase;
@@ -442,7 +443,7 @@ static const struct exar8250_platform exar8250_default_platform = {
 };
 
 static int iot2040_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
+				struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
 	u8 __iomem *p = port->membase;
@@ -471,7 +472,7 @@ static int iot2040_rs485_config(struct uart_port *port,
 	value |= mode;
 	writeb(value, p + UART_EXAR_MPIOLVL_7_0);
 
-	return generic_rs485_config(port, rs485);
+	return generic_rs485_config(port, rs485, termios);
 }
 
 static const struct serial_rs485 iot2040_rs485_supported = {
diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 1fb86c73786c..e48d52534bef 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -192,7 +192,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 }
 
 static int fintek_8250_rs485_config(struct uart_port *port,
-			      struct serial_rs485 *rs485)
+			      struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	uint8_t config = 0;
 	struct fintek_8250 *pdata = port->private_data;
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 3a1cb51cbc91..1865f7bc5020 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -33,7 +33,7 @@ struct lpc18xx_uart_data {
 };
 
 static int lpc18xx_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
+				struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	u32 rs485_ctrl_reg = 0;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b6d71268aa7d..35c799641e32 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1554,7 +1554,7 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 
 /* We should do proper H/W transceiver setting before change to RS485 mode */
 static int pci_fintek_rs485_config(struct uart_port *port,
-			       struct serial_rs485 *rs485)
+				   struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct pci_dev *pci_dev = to_pci_dev(port->dev);
 	u8 setting;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f417c29507e1..0ec06995df89 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -664,7 +664,8 @@ EXPORT_SYMBOL_GPL(serial8250_em485_supported);
  * if the uart is incapable of driving RTS as a Transmit Enable signal in
  * hardware, relying on software emulation instead.
  */
-int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
+int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485,
+			    struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index eccd66625d25..aefb0600a82c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2198,7 +2198,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 static int pl011_rs485_config(struct uart_port *port,
-			      struct serial_rs485 *rs485)
+			      struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index ab2c5b2a1ce8..930d9aed90f5 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -581,7 +581,7 @@ static const struct uart_ops ar933x_uart_ops = {
 };
 
 static int ar933x_config_rs485(struct uart_port *port,
-				struct serial_rs485 *rs485conf)
+			       struct serial_rs485 *rs485conf, struct ktermios *termios)
 {
 	struct ar933x_uart_port *up =
 		container_of(port, struct ar933x_uart_port, port);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 74dd1d3ac46f..b032e7c30ce0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -286,7 +286,7 @@ static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
 
 /* Enable or disable the rs485 support */
 static int atmel_config_rs485(struct uart_port *port,
-			      struct serial_rs485 *rs485conf)
+			      struct serial_rs485 *rs485conf, struct ktermios *termios)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int mode;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index d35414cb3e4e..3e8da24a3f76 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1356,7 +1356,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 }
 
 static int lpuart_config_rs485(struct uart_port *port,
-			struct serial_rs485 *rs485)
+			       struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
@@ -1386,7 +1386,7 @@ static int lpuart_config_rs485(struct uart_port *port,
 }
 
 static int lpuart32_config_rs485(struct uart_port *port,
-			struct serial_rs485 *rs485)
+				 struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4edde54175f..8a63ab6e0d8e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1908,7 +1908,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 
 /* called with port.lock taken and irqs off or from .probe without locking */
 static int imx_uart_rs485_config(struct uart_port *port,
-				 struct serial_rs485 *rs485conf)
+				 struct serial_rs485 *rs485conf, struct ktermios *termios)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr2;
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d7d1791fcb57..0e1dfad03825 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1027,7 +1027,7 @@ static void max310x_rs_proc(struct work_struct *ws)
 }
 
 static int max310x_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
+				struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 036f178e3d66..fbdf8c53ddd0 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -431,7 +431,8 @@ static int mcf_verify_port(struct uart_port *port, struct serial_struct *ser)
 /****************************************************************************/
 
 /* Enable or disable the RS485 support */
-static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485,
+			    struct ktermios *termios)
 {
 	unsigned char mr1, mr2;
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 98622c35d896..07446bcbfa8c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1325,7 +1325,8 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
 /* Enable or disable the rs485 support */
 static int
-serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485,
+			 struct ktermios *termios)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned int mode;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 2ceecaa4a478..f84c693ef5e7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1128,7 +1128,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 }
 
 static int sc16is7xx_config_rs485(struct uart_port *port,
-				  struct serial_rs485 *rs485)
+				  struct serial_rs485 *rs485, struct ktermios *termios)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 621fc15e2e54..76bb1b77b06e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1359,7 +1359,8 @@ int uart_rs485_config(struct uart_port *port)
 
 	uart_sanitize_serial_rs485(port, rs485);
 
-	ret = port->rs485_config(port, rs485);
+	ret = port->rs485_config(port, rs485, NULL);
+
 	if (ret)
 		memset(rs485, 0, sizeof(*rs485));
 
@@ -1383,7 +1384,7 @@ static int uart_get_rs485_config(struct uart_port *port,
 	return 0;
 }
 
-static int uart_set_rs485_config(struct uart_port *port,
+static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			 struct serial_rs485 __user *rs485_user)
 {
 	struct serial_rs485 rs485;
@@ -1402,7 +1403,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 	uart_sanitize_serial_rs485(port, &rs485);
 
 	spin_lock_irqsave(&port->lock, flags);
-	ret = port->rs485_config(port, &rs485);
+	ret = port->rs485_config(port, &rs485, &tty->termios);
 	if (!ret)
 		port->rs485 = rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1511,6 +1512,10 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	if (ret != -ENOIOCTLCMD)
 		goto out;
 
+	/* rs485_config requires more locking than others */
+	if (cmd == TIOCGRS485)
+		down_write(&tty->termios_rwsem);
+
 	mutex_lock(&port->mutex);
 	uport = uart_port_check(state);
 
@@ -1534,7 +1539,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 		break;
 
 	case TIOCSRS485:
-		ret = uart_set_rs485_config(uport, uarg);
+		ret = uart_set_rs485_config(tty, uport, uarg);
 		break;
 
 	case TIOCSISO7816:
@@ -1551,6 +1556,8 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	}
 out_up:
 	mutex_unlock(&port->mutex);
+	if (cmd == TIOCGRS485)
+		up_write(&tty->termios_rwsem);
 out:
 	return ret;
 }
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index db3dd9731ee1..de8e3cbda4f3 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -98,7 +98,7 @@ static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 }
 
 static int stm32_usart_config_rs485(struct uart_port *port,
-				    struct serial_rs485 *rs485conf)
+				    struct serial_rs485 *rs485conf, struct ktermios *termios)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5518b70177b3..9577cffb5593 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -132,7 +132,8 @@ struct uart_port {
 				      unsigned int old);
 	void			(*handle_break)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
-						struct serial_rs485 *rs485);
+						struct serial_rs485 *rs485,
+						struct ktermios *termios);
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
 	unsigned int		irq;			/* irq number */
-- 
2.30.2

