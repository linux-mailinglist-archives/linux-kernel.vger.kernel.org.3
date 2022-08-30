Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C95A6B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH3SB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiH3SB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50910F0;
        Tue, 30 Aug 2022 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661882486; x=1693418486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r26EgdVjpjI9j+Ro5V64X2jSNPyGDO+sYZnVzSN3DHE=;
  b=F6FK5zkDZ/MMhePTPQcDxsT1C4s+6cBM4jgZAmeRSsNONxT0M7jqv1JW
   oGYCeYfXBaEyqm7gW7Yno0vsb5HMoHTDstUG4dKLf5MGe+RezsULUlFjj
   TySBYH6rg9ALj2ZzvGlyrU5TXkRfQCrzViQMz6a0zQYo3ZgebZy9P/bV2
   2jKpszJZJpPiiPtMww9hcOUOraNCotwImUBvttEQ6LqNSk5LQbDk6SNoF
   1MfcjKszrss0NuSycWBX1HxIu8KX2JXDET8Y7lKN6aawAZfeL1yKH1sZH
   AKATYEy6a+cVeMzYiMTJPBEBRKit37QZGzC1WgQZndRPqONX7MeBmy88v
   w==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178360253"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 11:01:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 11:01:23 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 11:01:18 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for the quad-uart function in the  multi-function endpoint of pci1xxxx device.
Date:   Tue, 30 Aug 2022 23:30:53 +0530
Message-ID: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. Quad-uart is one of the functions in the
multi-function endpoint. This driver loads for the quad-uart and
enumerates single or multiple instances of uart based on the PCIe
subsystem device ID.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 MAINTAINERS                             |   6 +
 drivers/tty/serial/8250/8250_pci1xxxx.c | 463 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |   9 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   3 +
 6 files changed, 490 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..b2021425ce08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -218,6 +218,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 F:	drivers/tty/serial/8250*
 F:	include/linux/serial_8250.h
 
+MICROCHIP PCIe UART DRIVER
+M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_pci1xxxx.c
+
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 L:	netdev@vger.kernel.org
 S:	Orphan / Obsolete
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
new file mode 100644
index 000000000000..56852ae0585e
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Probe module for 8250/16550-type MCHP PCI serial ports.
+ *
+ *  Based on drivers/tty/serial/8250/8250_pci.c,
+ *
+ *  Copyright (C) 2022 Microchip Technology Inc., All Rights Reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_core.h>
+#include <linux/8250_pci.h>
+#include <linux/serial_8250.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <asm/byteorder.h>
+#include "8250.h"
+
+#define PCI_VENDOR_ID_MCHP_PCI1XXXX	0x1055
+
+#define PCI_DEVICE_ID_MCHP_PCI12000	0xA002
+#define PCI_DEVICE_ID_MCHP_PCI11010	0xA012
+#define PCI_DEVICE_ID_MCHP_PCI11101	0xA022
+#define PCI_DEVICE_ID_MCHP_PCI11400	0xA032
+#define PCI_DEVICE_ID_MCHP_PCI11414	0xA042
+
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p	0x0001
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012	0x0002
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013	0x0003
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023	0x0004
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123	0x0005
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01	0x0006
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02	0x0007
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03	0x0008
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12	0x0009
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13	0x000A
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23	0x000B
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0	0x000C
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1	0x000D
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2	0x000E
+#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3	0x000F
+
+#define PCI_SUBDEVICE_ID_MCHP_PCI12000	0xA002
+#define PCI_SUBDEVICE_ID_MCHP_PCI11010	0xA012
+#define PCI_SUBDEVICE_ID_MCHP_PCI11101	0xA022
+#define PCI_SUBDEVICE_ID_MCHP_PCI11400	0xA032
+#define PCI_SUBDEVICE_ID_MCHP_PCI11414	0xA042
+
+#define UART_ACTV_REG			0x11
+#define UART_ACTV_SET_ACTIVE		BIT(0)
+
+#define ADCL_CFG_REG			0x40
+#define ADCL_CFG_POL_SEL		BIT(2)
+#define ADCL_CFG_PIN_SEL		BIT(1)
+#define ADCL_CFG_EN			BIT(0)
+
+#define CLK_SEL_REG			0x50
+#define CLK_SEL_MASK			GENMASK(1, 0)
+#define CLK_SEL_166MHZ			0x01
+#define CLK_SEL_500MHZ			0x02
+
+#define CLK_DIVISOR_REG			0x54
+
+#define UART_PCI_CTRL_REG		0x80
+#define UART_PCI_CTRL_SET_MULTIPLE_MSI	BIT(4)
+
+#define UART_WAKE_REG			0x8C
+#define UART_WAKE_MASK_REG		0x90
+#define UART_WAKE_N_PIN			BIT(2)
+#define UART_WAKE_NCTS			BIT(1)
+#define UART_WAKE_INT			BIT(0)
+#define UART_WAKE_SRCS			(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
+
+#define UART_BIT_SAMPLE_CNT 16
+
+struct pci1xxxx_8250 {
+	struct pci_dev		*dev;
+	unsigned int		nr;
+	void __iomem		*membase;
+	int			line[];
+};
+
+static int setup_port(struct pci1xxxx_8250 *priv, struct uart_8250_port *port,
+		      int bar, int offset, int regshift)
+
+{
+	struct pci_dev *dev = priv->dev;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
+		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
+			return -ENOMEM;
+
+		port->port.iotype = UPIO_MEM;
+		port->port.iobase = 0;
+		port->port.mapbase = pci_resource_start(dev, bar) + offset;
+		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
+		port->port.regshift = regshift;
+	} else {
+		port->port.iotype = UPIO_PORT;
+		port->port.iobase = pci_resource_start(dev, bar) + offset;
+		port->port.mapbase = 0;
+		port->port.membase = NULL;
+		port->port.regshift = 0;
+	}
+
+	return 0;
+}
+
+static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
+				      struct ktermios *termios,
+				      struct serial_rs485 *rs485)
+{
+	u8 data = 0;
+
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
+			data |= ADCL_CFG_POL_SEL;
+			rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
+		}
+	}
+
+	rs485->delay_rts_after_send = 0;
+	rs485->delay_rts_before_send = 0;
+	writeb(data, (port->membase + ADCL_CFG_REG));
+	port->rs485 = *rs485;
+
+	return 0;
+}
+
+static void mchp_pci1xxxx_set_termios(struct uart_port *port,
+				      struct ktermios *termios,
+				      struct ktermios *old)
+{
+	const unsigned int standard_baud_list[] = {50, 75, 110, 134, 150, 300,
+						600, 1200, 1800, 2000, 2400, 3600,
+						4800, 7200, 9600, 19200, 38400, 57600,
+						115200, 125000, 136400, 150000, 166700,
+						187500, 214300, 250000, 300000, 375000,
+						500000, 750000, 1000000, 1500000};
+	unsigned int baud = tty_termios_baud_rate(termios);
+	unsigned int baud_clock;
+	unsigned int quot;
+	unsigned int frac;
+	unsigned int i;
+
+	baud = tty_termios_baud_rate(termios);
+	serial8250_do_set_termios(port, termios, NULL);
+
+	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
+		writel((port->custom_divisor & 0x3FFFFFFF),
+		       (port->membase + CLK_DIVISOR_REG));
+	} else {
+		for (i = 0; i < ARRAY_SIZE(standard_baud_list); i++) {
+			if (baud == standard_baud_list[i])
+				return;
+		}
+		tty_termios_encode_baud_rate(termios, baud, baud);
+
+		baud = uart_get_baud_rate(port, termios, old,
+					  50, 1500000);
+		baud_clock = readb(port->membase + CLK_SEL_REG);
+
+		if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_500MHZ) {
+			quot = 500000000 / (16 * baud);
+			writel(quot, (port->membase + CLK_DIVISOR_REG));
+		} else if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_166MHZ) {
+			quot = (166667 * 1000) / (16 * baud);
+			writel(quot, (port->membase + CLK_DIVISOR_REG));
+		} else {
+			quot = ((1000000000) / (baud * UART_BIT_SAMPLE_CNT));
+			frac = (((1000000000 - (quot * baud *
+				UART_BIT_SAMPLE_CNT)) / UART_BIT_SAMPLE_CNT)
+				* 255) / baud;
+			writel(frac | (quot << 8),
+			       (port->membase + CLK_DIVISOR_REG));
+		}
+	}
+}
+
+static int pci1xxxx_get_num_ports(struct pci_dev *dev)
+{
+	int nr_ports = 1;
+
+	switch (dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3:
+		nr_ports = 1;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23:
+		nr_ports = 2;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013:
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023:
+		nr_ports = 3;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p:
+	case PCI_SUBDEVICE_ID_MCHP_PCI11414:
+		nr_ports = 4;
+		break;
+	}
+
+	return nr_ports;
+}
+
+static int mchp_pci1xxxx_setup(struct pci1xxxx_8250 *priv,
+			       struct uart_8250_port *port, int idx)
+{
+	int first_offset = 0;
+	int offset;
+	u8 *data;
+	int ret;
+
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1:
+		first_offset = 256;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2:
+		first_offset = 512;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3:
+		first_offset = 768;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02:
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03:
+		if (idx > 0)
+			idx += 2;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12:
+		first_offset = 256;
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13:
+		first_offset = 256;
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23:
+		first_offset = 512;
+		break;
+
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123:
+		first_offset = 256;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023:
+		if (idx > 0)
+			idx++;
+		break;
+	}
+
+	data = devm_kzalloc(&priv->dev->dev, sizeof(u8), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	offset = first_offset + (idx * 256);
+	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	port->port.type = PORT_MCHP16550A;
+	port->port.rs485_config = mchp_pci1xxxx_rs485_config;
+	port->port.set_termios = mchp_pci1xxxx_set_termios;
+	ret = setup_port(priv, port, 0x00, offset, 0x00);
+	if (ret < 0)
+		return ret;
+
+	writeb(UART_ACTV_SET_ACTIVE, port->port.membase + UART_ACTV_REG);
+	writeb(UART_WAKE_SRCS, port->port.membase + UART_WAKE_REG);
+	writeb(UART_WAKE_N_PIN, port->port.membase + UART_WAKE_MASK_REG);
+
+	return 0;
+}
+
+void mchp_pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
+			      struct uart_8250_port *uart, int idx)
+{
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_MCHP_PCI12000:
+	case PCI_SUBDEVICE_ID_MCHP_PCI11010:
+	case PCI_SUBDEVICE_ID_MCHP_PCI11101:
+	case PCI_SUBDEVICE_ID_MCHP_PCI11400:
+		uart->port.irq = pci_irq_vector(priv->dev, 0);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1:
+		uart->port.irq = pci_irq_vector(priv->dev, 1);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2:
+		uart->port.irq = pci_irq_vector(priv->dev, 2);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3:
+		uart->port.irq = pci_irq_vector(priv->dev, 3);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02:
+		if (idx > 0)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03:
+		if (idx > 0)
+			idx += 2;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13:
+		if (idx > 0)
+			idx += 1;
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 2);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023:
+		if (idx > 0)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p:
+	case PCI_SUBDEVICE_ID_MCHP_PCI11414:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	}
+}
+
+static int pci1xxxx_serial_probe(struct pci_dev *dev,
+				 const struct pci_device_id *ent)
+{
+	struct pci1xxxx_8250 *priv;
+	struct uart_8250_port uart;
+	unsigned int nr_ports, i;
+	int num_vectors = 0;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	pci_save_state(dev);
+	if (rc)
+		return rc;
+
+	nr_ports = pci1xxxx_get_num_ports(dev);
+
+	priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
+
+	priv->membase = pcim_iomap(dev, 0, 0);
+	priv->dev = dev;
+	priv->nr =  nr_ports;
+
+	if (!priv)
+		return -ENOMEM;
+
+	pci_set_master(dev);
+
+	num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
+	if (num_vectors < 0)
+		return rc;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;
+	uart.port.uartclk = 48000000;
+	uart.port.dev = &dev->dev;
+
+	if (num_vectors == 4)
+		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));
+	else
+		uart.port.irq = pci_irq_vector(dev, 0);
+
+	for (i = 0; i < nr_ports; i++) {
+		if (num_vectors == 4)
+			mchp_pci1xxxx_irq_assign(priv, &uart, i);
+		rc = mchp_pci1xxxx_setup(priv, &uart, i);
+		if (rc) {
+			dev_err(&dev->dev, "Failed to setup port %u\n", i);
+			break;
+		}
+		priv->line[i] = serial8250_register_8250_port(&uart);
+
+		if (priv->line[i] < 0) {
+			dev_err(&dev->dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq,
+				uart.port.iotype, priv->line[i]);
+			break;
+		}
+	}
+
+	pci_set_drvdata(dev, priv);
+
+	return 0;
+}
+
+static void pci1xxxx_serial_remove(struct pci_dev *dev)
+{
+	struct pci1xxxx_8250 *priv = pci_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < priv->nr; i++)
+		serial8250_unregister_port(priv->line[i]);
+}
+
+static const struct pci_device_id pci1xxxx_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11010) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11101) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11400) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11414) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI12000) },
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, pci1xxxx_pci_tbl);
+
+static struct pci_driver pci1xxxx_pci_driver = {
+	.name		= "pci1xxxx serial",
+	.probe		= pci1xxxx_serial_probe,
+	.remove	= pci1xxxx_serial_remove,
+	.id_table	= pci1xxxx_pci_tbl,
+};
+
+module_pci_driver(pci1xxxx_pci_driver);
+
+MODULE_DESCRIPTION("Microchip Technology Inc. PCIe to UART module");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..64ba32837838 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -313,6 +313,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_MCHP16550A] = {
+		.name           = "MCHP16550A",
+		.fifo_size      = 256,
+		.tx_loadsz      = 256,
+		.fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes   = {2, 66, 130, 194},
+		.flags          = UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..d4b1344d0628 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -528,6 +528,15 @@ config SERIAL_8250_TEGRA
 	  Select this option if you have machine with an NVIDIA Tegra SoC and
 	  wish to enable 8250 serial driver for the Tegra serial interfaces.
 
+config SERIAL_8250_PCI1XXXX
+	tristate "Microchip 8250 based serial port"
+	depends on SERIAL_8250
+	help
+	 Select this option if you have a setup with Microchip PCIe
+	 Switch with serial port enabled and wish to enable 8250
+	 serial driver for the serial interface. This driver support
+	 will ensure to support baud rates upto 1.5Mpbs.
+
 config SERIAL_8250_BCM7271
 	tristate "Broadcom 8250 based serial port"
 	depends on SERIAL_8250 && (ARCH_BRCMSTB || COMPILE_TEST)
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..e900ff11e321 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 3ba34d8378bd..2bd82ac0ae1a 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -276,4 +276,7 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* MCHP 16550A UART with 256 byte FIFOs */
+#define PORT_MCHP16550A	124
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.25.1

