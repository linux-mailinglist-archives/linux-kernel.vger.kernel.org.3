Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C676E5A5CED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiH3Ha6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiH3Hag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:30:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BD696FB;
        Tue, 30 Aug 2022 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661844627; x=1693380627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9/Bb0nFsj/7oGrsG6tpQJCSmsT4lrVGDQ4Ipd7L0Tw=;
  b=Qw/8fV1plxTp358eTbUF+JXmI45ic2wE0CYJnlF2MDZ9lg1UF9HY8svg
   yqYwe/IvF+whtVU9VXKcjCR5lLaye799V1YXlSxvpzEDIkDj1TlAIf/W0
   bVEQtRUn7yrHYhiAyjguY/UFUrIpp5z7SRn3YHvijFUW/LpQT1dBQWTAP
   GzmQVAyXjVzxUgB1j0M2xIoa05e3A/Y03fPOlPMhJrDPP8lKdzx5oi/H6
   HbTGtwj2xnrLxlT2aeFNxw7MSgcsbdfmQURLxKNvyacIpnAz8OQxWOi3D
   /t7ev/48MD82P1MD6IZEVfGS6yjHm9wj3vp06dLVZ9wt3TBUXii1HupcP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295887691"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="295887691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641262711"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v2 4/4] serial: Add kserial_rs485 to avoid wasted space due to .padding
Date:   Tue, 30 Aug 2022 10:29:56 +0300
Message-Id: <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct serial_rs485 has a .padding field to make uapi updates
easier. It wastes space, however. Create struct kserial_rs485 which is
a kerner counterpart w/o padding.

serial_rs485_to_user()'s rs485 can now become const as padding is dealt
within the local variable.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        |  2 +-
 drivers/tty/serial/8250/8250.h                |  4 +-
 drivers/tty/serial/8250/8250_dwlib.c          |  6 +--
 drivers/tty/serial/8250/8250_exar.c           | 12 ++---
 drivers/tty/serial/8250/8250_fintek.c         |  6 +--
 drivers/tty/serial/8250/8250_lpc18xx.c        |  4 +-
 drivers/tty/serial/8250/8250_pci.c            |  4 +-
 drivers/tty/serial/8250/8250_port.c           |  4 +-
 drivers/tty/serial/amba-pl011.c               |  4 +-
 drivers/tty/serial/ar933x_uart.c              |  8 +--
 drivers/tty/serial/atmel_serial.c             |  4 +-
 drivers/tty/serial/fsl_lpuart.c               |  6 +--
 drivers/tty/serial/imx.c                      |  6 +--
 drivers/tty/serial/max310x.c                  |  4 +-
 drivers/tty/serial/mcf.c                      |  4 +-
 drivers/tty/serial/omap-serial.c              |  6 +--
 drivers/tty/serial/sc16is7xx.c                |  6 +--
 drivers/tty/serial/serial_core.c              | 54 +++++++++++++------
 drivers/tty/serial/stm32-usart.c              | 12 ++---
 include/linux/serial_core.h                   | 29 ++++++++--
 include/uapi/linux/serial.h                   |  2 +
 21 files changed, 118 insertions(+), 69 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 6ebad75c74ed..7e496336a01b 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -41,7 +41,7 @@ RS485 Serial Communications
    implement the rs485_config callback and provide rs485_supported in the
    uart_port structure. The serial core calls rs485_config to do the device
    specific part in response to TIOCSRS485 ioctl (see below). The rs485_config
-   callback receives a pointer to a sanitizated serial_rs485 structure. The
+   callback receives a pointer to a sanitizated kserial_rs485 structure. The
    serial_rs485 userspace provides is sanitized before calling rs485_config
    using rs485_supported that indicates what RS485 features the driver supports
    for the uart_port. TIOCGRS485 ioctl can be used to read back the
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 287153d32536..4e22f8d50e91 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -204,11 +204,11 @@ void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
 int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
-			    struct serial_rs485 *rs485);
+			    struct kserial_rs485 *rs485);
 void serial8250_em485_start_tx(struct uart_8250_port *p);
 void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
-extern struct serial_rs485 serial8250_em485_supported;
+extern struct kserial_rs485 serial8250_em485_supported;
 
 /* MCR <-> TIOCM conversion */
 static inline int serial8250_TIOCM_to_MCR(int tiocm)
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index dbe4d44f60d4..a628ed2c235b 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -134,7 +134,7 @@ static void dw8250_update_rar(struct uart_port *p, u32 addr)
 		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
 }
 
-static void dw8250_rs485_set_addr(struct uart_port *p, struct serial_rs485 *rs485,
+static void dw8250_rs485_set_addr(struct uart_port *p, struct kserial_rs485 *rs485,
 				  struct ktermios *termios)
 {
 	u32 lcr = dw8250_readl_ext(p, DW_UART_LCR_EXT);
@@ -177,7 +177,7 @@ static void dw8250_rs485_set_addr(struct uart_port *p, struct serial_rs485 *rs48
 }
 
 static int dw8250_rs485_config(struct uart_port *p, struct ktermios *termios,
-			       struct serial_rs485 *rs485)
+			       struct kserial_rs485 *rs485)
 {
 	u32 tcr;
 
@@ -232,7 +232,7 @@ static bool dw8250_detect_rs485_hw(struct uart_port *p)
 	return reg;
 }
 
-static const struct serial_rs485 dw8250_rs485_supported = {
+static const struct kserial_rs485 dw8250_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_RTS_ON_SEND |
 		 SER_RS485_RTS_AFTER_SEND | SER_RS485_ADDRB | SER_RS485_ADDR_RECV |
 		 SER_RS485_ADDR_DEST,
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 314a05e009df..9fef2056a9b5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -113,8 +113,8 @@ struct exar8250;
 
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
-			    struct serial_rs485 *rs485);
-	const struct serial_rs485 *rs485_supported;
+			    struct kserial_rs485 *rs485);
+	const struct kserial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 	void (*unregister_gpio)(struct uart_8250_port *);
 };
@@ -411,7 +411,7 @@ static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
 }
 
 static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
-				struct serial_rs485 *rs485)
+				struct kserial_rs485 *rs485)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
 	u8 __iomem *p = port->membase;
@@ -431,7 +431,7 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
 	return 0;
 }
 
-static const struct serial_rs485 generic_rs485_supported = {
+static const struct kserial_rs485 generic_rs485_supported = {
 	.flags = SER_RS485_ENABLED,
 };
 
@@ -443,7 +443,7 @@ static const struct exar8250_platform exar8250_default_platform = {
 };
 
 static int iot2040_rs485_config(struct uart_port *port, struct ktermios *termios,
-				struct serial_rs485 *rs485)
+				struct kserial_rs485 *rs485)
 {
 	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
 	u8 __iomem *p = port->membase;
@@ -475,7 +475,7 @@ static int iot2040_rs485_config(struct uart_port *port, struct ktermios *termios
 	return generic_rs485_config(port, termios, rs485);
 }
 
-static const struct serial_rs485 iot2040_rs485_supported = {
+static const struct kserial_rs485 iot2040_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
 };
 
diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 65b6b3cbaff6..d3d2e25dd06b 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -192,7 +192,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 }
 
 static int fintek_8250_rs485_config(struct uart_port *port, struct ktermios *termios,
-			      struct serial_rs485 *rs485)
+			      struct kserial_rs485 *rs485)
 {
 	uint8_t config = 0;
 	struct fintek_8250 *pdata = port->private_data;
@@ -411,13 +411,13 @@ static int probe_setup_port(struct fintek_8250 *pdata,
 }
 
 /* Only the first port supports delays */
-static const struct serial_rs485 fintek_8250_rs485_supported_port0 = {
+static const struct kserial_rs485 fintek_8250_rs485_supported_port0 = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
 
-static const struct serial_rs485 fintek_8250_rs485_supported = {
+static const struct kserial_rs485 fintek_8250_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 };
 
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 6dc85aaba5d0..0619427683cf 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -33,7 +33,7 @@ struct lpc18xx_uart_data {
 };
 
 static int lpc18xx_rs485_config(struct uart_port *port, struct ktermios *termios,
-				struct serial_rs485 *rs485)
+				struct kserial_rs485 *rs485)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	u32 rs485_ctrl_reg = 0;
@@ -81,7 +81,7 @@ static void lpc18xx_uart_serial_out(struct uart_port *p, int offset, int value)
 	writel(value, p->membase + offset);
 }
 
-static const struct serial_rs485 lpc18xx_rs485_supported = {
+static const struct kserial_rs485 lpc18xx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_after_send = 1,
 	/* Delay RTS before send is not supported */
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6f66dc2ebacc..8675b0d9658d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1554,7 +1554,7 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 
 /* We should do proper H/W transceiver setting before change to RS485 mode */
 static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *termios,
-			       struct serial_rs485 *rs485)
+			       struct kserial_rs485 *rs485)
 {
 	struct pci_dev *pci_dev = to_pci_dev(port->dev);
 	u8 setting;
@@ -1583,7 +1583,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
 	return 0;
 }
 
-static const struct serial_rs485 pci_fintek_rs485_supported = {
+static const struct kserial_rs485 pci_fintek_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..2345b6fbac6d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -647,7 +647,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
 
-struct serial_rs485 serial8250_em485_supported = {
+struct kserial_rs485 serial8250_em485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_TERMINATE_BUS | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
@@ -665,7 +665,7 @@ EXPORT_SYMBOL_GPL(serial8250_em485_supported);
  * hardware, relying on software emulation instead.
  */
 int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
-			    struct serial_rs485 *rs485)
+			    struct kserial_rs485 *rs485)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 15f0e4d88c5a..e78cd0759dc1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2215,7 +2215,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
-			      struct serial_rs485 *rs485)
+			      struct kserial_rs485 *rs485)
 {
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
@@ -2765,7 +2765,7 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	return ret;
 }
 
-static const struct serial_rs485 pl011_rs485_supported = {
+static const struct kserial_rs485 pl011_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 32caeac12985..30c716b4a105 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -391,7 +391,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
 static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
 {
 	struct circ_buf *xmit = &up->port.state->xmit;
-	struct serial_rs485 *rs485conf = &up->port.rs485;
+	struct kserial_rs485 *rs485conf = &up->port.rs485;
 	int count;
 	bool half_duplex_send = false;
 
@@ -581,7 +581,7 @@ static const struct uart_ops ar933x_uart_ops = {
 };
 
 static int ar933x_config_rs485(struct uart_port *port, struct ktermios *termios,
-				struct serial_rs485 *rs485conf)
+				struct kserial_rs485 *rs485conf)
 {
 	return 0;
 }
@@ -693,8 +693,8 @@ static struct uart_driver ar933x_uart_driver = {
 	.cons		= NULL, /* filled in runtime */
 };
 
-static const struct serial_rs485 ar933x_no_rs485 = {};
-static const struct serial_rs485 ar933x_rs485_supported = {
+static const struct kserial_rs485 ar933x_no_rs485 = {};
+static const struct kserial_rs485 ar933x_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 };
 
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 30ba9eef7b39..be0296714585 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -284,7 +284,7 @@ static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
 
 /* Enable or disable the rs485 support */
 static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
-			      struct serial_rs485 *rs485conf)
+			      struct kserial_rs485 *rs485conf)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int mode;
@@ -2471,7 +2471,7 @@ static const struct uart_ops atmel_pops = {
 #endif
 };
 
-static const struct serial_rs485 atmel_rs485_supported = {
+static const struct kserial_rs485 atmel_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6c33cd228c8..7b28cb8bee1e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1374,7 +1374,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 }
 
 static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
-			struct serial_rs485 *rs485)
+			struct kserial_rs485 *rs485)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
@@ -1404,7 +1404,7 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 }
 
 static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termios,
-			struct serial_rs485 *rs485)
+			struct kserial_rs485 *rs485)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
@@ -2633,7 +2633,7 @@ static struct uart_driver lpuart_reg = {
 	.cons		= LPUART_CONSOLE,
 };
 
-static const struct serial_rs485 lpuart_rs485_supported = {
+static const struct kserial_rs485 lpuart_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* delay_rts_* and RX_DURING_TX are not supported */
 };
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 522445a8f666..0768e8270153 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1908,7 +1908,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 
 /* called with port.lock taken and irqs off or from .probe without locking */
 static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termios,
-				 struct serial_rs485 *rs485conf)
+				 struct kserial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr2;
@@ -2196,8 +2196,8 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
-static const struct serial_rs485 imx_no_rs485 = {};	/* No RS485 if no RTS */
-static const struct serial_rs485 imx_rs485_supported = {
+static const struct kserial_rs485 imx_no_rs485 = {};	/* No RS485 if no RTS */
+static const struct kserial_rs485 imx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ab10ca4a45b5..6a8ab63d1072 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1037,7 +1037,7 @@ static void max310x_rs_proc(struct work_struct *ws)
 }
 
 static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
-				struct serial_rs485 *rs485)
+				struct kserial_rs485 *rs485)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
@@ -1257,7 +1257,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 }
 #endif
 
-static const struct serial_rs485 max310x_rs485_supported = {
+static const struct kserial_rs485 max310x_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index f4aaaadd0742..9c86218ae29d 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -432,7 +432,7 @@ static int mcf_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 /* Enable or disable the RS485 support */
 static int mcf_config_rs485(struct uart_port *port, struct ktermios *termios,
-			    struct serial_rs485 *rs485)
+			    struct kserial_rs485 *rs485)
 {
 	unsigned char mr1, mr2;
 
@@ -453,7 +453,7 @@ static int mcf_config_rs485(struct uart_port *port, struct ktermios *termios,
 	return 0;
 }
 
-static const struct serial_rs485 mcf_rs485_supported = {
+static const struct kserial_rs485 mcf_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0aa666e247d5..013d843833a9 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1325,7 +1325,7 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 /* Enable or disable the rs485 support */
 static int
 serial_omap_config_rs485(struct uart_port *port, struct ktermios *termios,
-			 struct serial_rs485 *rs485)
+			 struct kserial_rs485 *rs485)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned int mode;
@@ -1516,7 +1516,7 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 static int serial_omap_probe_rs485(struct uart_omap_port *up,
 				   struct device *dev)
 {
-	struct serial_rs485 *rs485conf = &up->port.rs485;
+	struct kserial_rs485 *rs485conf = &up->port.rs485;
 	struct device_node *np = dev->of_node;
 	enum gpiod_flags gflags;
 	int ret;
@@ -1559,7 +1559,7 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	return 0;
 }
 
-static const struct serial_rs485 serial_omap_rs485_supported = {
+static const struct kserial_rs485 serial_omap_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 259e08cc347c..e21f30d9fb2f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -836,7 +836,7 @@ static void sc16is7xx_reconf_rs485(struct uart_port *port)
 	const u32 mask = SC16IS7XX_EFCR_AUTO_RS485_BIT |
 			 SC16IS7XX_EFCR_RTS_INVERT_BIT;
 	u32 efcr = 0;
-	struct serial_rs485 *rs485 = &port->rs485;
+	struct kserial_rs485 *rs485 = &port->rs485;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&port->lock, irqflags);
@@ -1128,7 +1128,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 }
 
 static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termios,
-				  struct serial_rs485 *rs485)
+				  struct kserial_rs485 *rs485)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
@@ -1353,7 +1353,7 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 }
 #endif
 
-static const struct serial_rs485 sc16is7xx_rs485_supported = {
+static const struct kserial_rs485 sc16is7xx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4a4ed619ee71..62c188490988 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1291,7 +1291,7 @@ static int uart_get_icount(struct tty_struct *tty,
 				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
 				 SER_RS485_TERMINATE_BUS)
 
-static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
+static int uart_check_rs485_flags(struct uart_port *port, struct kserial_rs485 *rs485)
 {
 	u32 flags = rs485->flags;
 
@@ -1320,7 +1320,7 @@ static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *r
 }
 
 static void uart_sanitize_serial_rs485_delays(struct uart_port *port,
-					      struct serial_rs485 *rs485)
+					      struct kserial_rs485 *rs485)
 {
 	if (!port->rs485_supported.delay_rts_before_send) {
 		if (rs485->delay_rts_before_send) {
@@ -1351,7 +1351,7 @@ static void uart_sanitize_serial_rs485_delays(struct uart_port *port,
 	}
 }
 
-static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+static void uart_sanitize_serial_rs485(struct uart_port *port, struct kserial_rs485 *rs485)
 {
 	u32 supported_flags = port->rs485_supported.flags;
 
@@ -1378,7 +1378,7 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 }
 
 static void uart_set_rs485_termination(struct uart_port *port,
-				       const struct serial_rs485 *rs485)
+				       const struct kserial_rs485 *rs485)
 {
 	if (!(rs485->flags & SER_RS485_ENABLED))
 		return;
@@ -1389,7 +1389,7 @@ static void uart_set_rs485_termination(struct uart_port *port,
 
 int uart_rs485_config(struct uart_port *port)
 {
-	struct serial_rs485 *rs485 = &port->rs485;
+	struct kserial_rs485 *rs485 = &port->rs485;
 	int ret;
 
 	uart_sanitize_serial_rs485(port, rs485);
@@ -1403,23 +1403,31 @@ int uart_rs485_config(struct uart_port *port)
 }
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
-static int serial_rs485_from_user(struct serial_rs485 *rs485,
+static int serial_rs485_from_user(struct kserial_rs485 *rs485,
 				  const struct serial_rs485 __user *rs485_user)
 {
-	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
+	struct serial_rs485 rs485_uapi;
+
+	if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
 		return -EFAULT;
 
+	*rs485 = *((struct kserial_rs485 *)&rs485_uapi);
+
 	return 0;
 }
 
 static int serial_rs485_to_user(struct serial_rs485 __user *rs485_user,
-				struct serial_rs485 *rs485)
+				const struct kserial_rs485 *rs485)
 {
+	struct serial_rs485 rs485_uapi;
+
+	*((struct kserial_rs485 *)&rs485_uapi) = *rs485;
+
 	/* Return clean padding area to userspace */
-	memset(rs485->padding0, 0, sizeof(rs485->padding0));
-	memset(rs485->padding1, 0, sizeof(rs485->padding1));
+	memset(rs485_uapi.padding0, 0, sizeof(rs485_uapi.padding0));
+	memset(rs485_uapi.padding1, 0, sizeof(rs485_uapi.padding1));
 
-	if (copy_to_user(rs485_user, rs485, sizeof(*rs485)))
+	if (copy_to_user(rs485_user, &rs485_uapi, sizeof(rs485_uapi)))
 		return -EFAULT;
 
 	return 0;
@@ -1428,7 +1436,7 @@ static int serial_rs485_to_user(struct serial_rs485 __user *rs485_user,
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485_user)
 {
-	struct serial_rs485 rs485;
+	struct kserial_rs485 rs485;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -1441,7 +1449,7 @@ static int uart_get_rs485_config(struct uart_port *port,
 static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			 struct serial_rs485 __user *rs485_user)
 {
-	struct serial_rs485 rs485;
+	struct kserial_rs485 rs485;
 	int ret;
 	unsigned long flags;
 
@@ -3415,7 +3423,7 @@ EXPORT_SYMBOL_GPL(uart_try_toggle_sysrq);
  */
 int uart_get_rs485_mode(struct uart_port *port)
 {
-	struct serial_rs485 *rs485conf = &port->rs485;
+	struct kserial_rs485 *rs485conf = &port->rs485;
 	struct device *dev = port->dev;
 	u32 rs485_delay[2];
 	int ret;
@@ -3471,7 +3479,23 @@ int uart_get_rs485_mode(struct uart_port *port)
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
 
-/* Compile-time assertions for serial_rs485 layout */
+/*
+ * Compile-time asserts for struct kserial_rs485 and struct serial_rs485 equality
+ * (except padding).
+ */
+static_assert(offsetof(struct kserial_rs485, flags) ==
+	      offsetof(struct serial_rs485, flags));
+static_assert(offsetof(struct kserial_rs485, delay_rts_before_send) ==
+	      offsetof(struct serial_rs485, delay_rts_before_send));
+static_assert(offsetof(struct kserial_rs485, delay_rts_after_send) ==
+	      offsetof(struct serial_rs485, delay_rts_after_send));
+static_assert(offsetof(struct kserial_rs485, addr_recv) ==
+	      offsetof(struct serial_rs485, addr_recv));
+static_assert(offsetof(struct kserial_rs485, addr_dest) ==
+	      offsetof(struct serial_rs485, addr_dest));
+static_assert(sizeof(struct kserial_rs485) <= sizeof(struct serial_rs485));
+
+/* Compile-time assertions for struct serial_rs485 layout */
 static_assert(offsetof(struct serial_rs485, padding) ==
               (offsetof(struct serial_rs485, delay_rts_after_send) + sizeof(__u32)));
 static_assert(offsetof(struct serial_rs485, padding1) ==
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2c85dbf165c4..8606bda9f7fa 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -169,7 +169,7 @@ static void stm32_usart_config_reg_rs485(u32 *cr1, u32 *cr3, u32 delay_ADE,
 }
 
 static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *termios,
-				    struct serial_rs485 *rs485conf)
+				    struct kserial_rs485 *rs485conf)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -220,7 +220,7 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 static int stm32_usart_init_rs485(struct uart_port *port,
 				  struct platform_device *pdev)
 {
-	struct serial_rs485 *rs485conf = &port->rs485;
+	struct kserial_rs485 *rs485conf = &port->rs485;
 
 	rs485conf->flags = 0;
 	rs485conf->delay_rts_before_send = 0;
@@ -532,7 +532,7 @@ static void stm32_usart_tc_interrupt_disable(struct uart_port *port)
 static void stm32_usart_rs485_rts_enable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
+	struct kserial_rs485 *rs485conf = &port->rs485;
 
 	if (stm32_port->hw_flow_control ||
 	    !(rs485conf->flags & SER_RS485_ENABLED))
@@ -550,7 +550,7 @@ static void stm32_usart_rs485_rts_enable(struct uart_port *port)
 static void stm32_usart_rs485_rts_disable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	struct serial_rs485 *rs485conf = &port->rs485;
+	struct kserial_rs485 *rs485conf = &port->rs485;
 
 	if (stm32_port->hw_flow_control ||
 	    !(rs485conf->flags & SER_RS485_ENABLED))
@@ -1094,7 +1094,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
-	struct serial_rs485 *rs485conf = &port->rs485;
+	struct kserial_rs485 *rs485conf = &port->rs485;
 	unsigned int baud, bits;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
@@ -1446,7 +1446,7 @@ static void stm32_usart_deinit_port(struct stm32_port *stm32port)
 	clk_disable_unprepare(stm32port->clk);
 }
 
-static const struct serial_rs485 stm32_rs485_supported = {
+static const struct kserial_rs485 stm32_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aef3145f2032..3a987af88ffe 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -31,6 +31,29 @@ struct serial_struct;
 struct device;
 struct gpio_desc;
 
+/**
+ * struct kserial_rs485 - kernel-side struct for controlling RS485 settings.
+ * @flags:			RS485 feature flags
+ * @delay_rts_before_send:	Delay before send (milliseconds)
+ * @delay_rts_after_send:	Delay after send (milliseconds)
+ * @addr_recv:			Receive filter for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_RECV is set).
+ * @addr_dest:			Destination address for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_DEST is set).
+ *
+ * Must match with struct serial_rs485 in include/uapi/linux/serial.h excluding
+ * the padding.
+ */
+struct kserial_rs485 {
+	__u32	flags;
+	__u32	delay_rts_before_send;
+	__u32	delay_rts_after_send;
+	struct {
+		__u8    addr_recv;
+		__u8    addr_dest;
+	};
+};
+
 /**
  * struct uart_ops -- interface between serial_core and the driver
  *
@@ -447,7 +470,7 @@ struct uart_port {
 	void			(*handle_break)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
 						struct ktermios *termios,
-						struct serial_rs485 *rs485);
+						struct kserial_rs485 *rs485);
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
 	unsigned int		irq;			/* irq number */
@@ -567,8 +590,8 @@ struct uart_port {
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
-	struct serial_rs485     rs485;
-	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
+	struct kserial_rs485	rs485;
+	struct kserial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index dbdc7865abdc..7063eb6b1617 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -138,6 +138,8 @@ struct serial_icounter_struct {
  *				  Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
  *				  Requires %SER_RS485_ADDRB.
+ *
+ * There's kernel counterpart struct kserial_rs485 of this struct without padding.
  */
 struct serial_rs485 {
 	__u32	flags;
-- 
2.30.2

